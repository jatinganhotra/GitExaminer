# Include diff, difffile classes
load 'diff.rb'
load 'difffile.rb'

# Inputs a and b are diffs
# 3rd argument is hash for specific checks
def PRINT_AND_EXIT(a,b,h)
  if h[:stats]
    if (a.stats.nil? || b.stats.nil? )
      PrintDiffInfoAndStats(a,b)
      raise "STATS NIL"
    end
  end

end

def DEBUG_LOGGER diffs_array
diffs_array.each do |diff|
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
  puts "The previous commit is \n" + diff.prev_commit_sha.to_s
  puts "The next commit is \n" + diff.next_commit_sha.to_s
  puts "The stats for the diff are \n" + diff.stats.to_s
  puts "The size of the diff is \n" + diff.num_difffiles.to_s
  diff.num_difffiles.times do |i|
    difffile = diff.difffiles[i]
    puts "Difffile #" + i.to_s + " :- "
    puts "The patch/ actual changes are \n" + difffile.patch
  end
  puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@"
end
end

def CompareDiffStatsFor2Difffiles( a,b, a_difffile_file_name, b_difffile_file_name)
  astats = a.stats
  bstats = b.stats
  # Rudimentary as already checked before
  raise "Error" if astats.nil? || bstats.nil?
  raise "Error" if astats[:total].nil? || bstats[:total].nil?

  a_file_stats = astats[:files][a_difffile_file_name]
  b_file_stats = bstats[:files][b_difffile_file_name]
  return false if a_file_stats.nil? || b_file_stats.nil?

  a_insertions = a_file_stats[:insertions]
  a_deletions = a_file_stats[:deletions]
  b_insertions = b_file_stats[:insertions]
  b_deletions  = b_file_stats[:deletions]
  return false if a_insertions != b_deletions || a_deletions != b_insertions

  true
end

# CompareDiffStats(diff.stats, cmp_diff.stats)
# Compare 2 diffs by their stats
def CompareDiffStats( a, b)

  # Rudimentary as already checked before
  raise "Error" if a.nil? || b.nil?
  raise "Error" if a[:total].nil? || b[:total].nil?

  a_num_files = a[:total][:files]
  b_num_files = b[:total][:files]
  unless a_num_files == b_num_files
    raise "Both stats must have the same number of files, \
        as we reached here only after checking num_difffiles"
  end

  i = 0
  stats_dont_match = false
    a[:files].each do |a_file, a_file_stats|
      a_insertions = a_file_stats[:insertions]
      a_deletions = a_file_stats[:deletions]

      # Find the stats for the same file in stats b
      b[:files].each do |b_file, b_file_stats|
        next if a_file != b_file

        b_insertions = b_file_stats[:insertions]
        b_deletions  = b_file_stats[:deletions]
        if a_insertions != b_deletions || a_deletions != b_insertions
          stats_dont_match = true
          break
        end
      end
      if stats_dont_match == true
        return false
      end
    end
  return true
end

def GetCorrepondingDifffileInB(a_difffile_file_name, b)
  is_present = false
  b.difffiles.each do |b_difffile|
    b_difffile_file_name = b_difffile.file_name
    if a_difffile_file_name == b_difffile_file_name
      is_present = true
      return [is_present, b_difffile]
      break
    end
  end
  return [false, nil]
end


def ComparePatchForDifffiles(a, b)
  a_additions = a.additions
  a_deletions = a.deletions
  b_additions = b.additions
  b_deletions = b.deletions

  c1 = a_additions == b_deletions
  c2 = a_deletions == b_additions

  if (c1 == true && c2 == true)
    return true
  else
    return false
  end
end

def CompareDiffPatch(a, b)
  a_numfiles = a.num_difffiles
  b_numfiles = b.num_difffiles

  # TODO - Enhancement for partial reverts.
  # The below condition will be false when you are looking for partial reverts
  # unless a_numfiles == b_numfiles
  #   raise "Both stats must have the same number of files, \
  #       as we reached here only after checking stats and num_difffiles"
  # end

  num_diffs_correct = 0
  # FIXME: Investigate when would the next line be true
  return false if a_numfiles == 0 || b_numfiles == 0
  raise "The difffiles array can't be nil" if a.difffiles.nil? || b.difffiles.nil?

  partial_diff_files = []
  a.difffiles.each do |a_difffile|
    a_difffile_file_name = a_difffile.file_name
    raise "Error !!! The file_name can't be nil" if a_difffile_file_name.nil?

    # Checkpoint #1 - The file_name must have a corresponding difffile in diff b
    is_present, b_difffile = GetCorrepondingDifffileInB(a_difffile_file_name, b)

    return false if is_present == false

    # TODO - Enhancement for partial reverts. Check if stats match for the given difffile
    b_difffile_file_name = b_difffile.file_name
    diff_stats_match = CompareDiffStatsFor2Difffiles(a,b, a_difffile_file_name, b_difffile_file_name)
    next if diff_stats_match == false

    # Checkpoint #2 - Compare the patches for both difffiles a and b
    a_patch = a_difffile.patch
    b_patch = b_difffile.patch
    do_patches_match = ComparePatchForDifffiles(a_patch, b_patch)
    if do_patches_match == false
      return false
    else
      partial_diff_files << a_difffile_file_name
      num_diffs_correct = num_diffs_correct + 1
    end
  end

  return true if ( num_diffs_correct == a_numfiles && num_diffs_correct == b_numfiles )
  # TODO - Enhancement for partial reverts
  if num_diffs_correct > 0
    return true, partial_diff_files
  end
end
