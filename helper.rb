# Include diff, difffile classes
load 'diff.rb'
load 'difffile.rb'

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

# CompareDiffStats(diff.stats, cmp_diff.stats)
# Compare 2 diffs by their stats
def CompareDiffStats( a, b)
  # puts "Stats for diff a"
  # ap a
  #
  # puts "Stats for diff b"
  # ap b

  a_num_files = a[:total][:files]
  b_num_files = b[:total][:files]
  unless a_num_files == b_num_files
    raise "Both stats must have the same number of files, \
        as we reached here only after checking num_difffiles"
  end

  i = 0
  stats_dont_match = false
    a[:files].each do |a_file, a_file_stats|
      #ap a_file_stats
      a_insertions = a_file_stats[:insertions]
      a_deletions = a_file_stats[:deletions]
      #puts "Insertions are - " + a_insertions.to_s
      #puts "Deletions are - " +  a_deletions.to_s

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
  puts "looking for a_difffile_file_name in diff b = " + a_difffile_file_name.to_s
  is_present = false
  b.difffiles.each do |b_difffile|
    b_difffile_file_name = b_difffile.file_name
    if a_difffile_file_name == b_difffile_file_name
      puts "Found a match with b_difffile_file_name = " + b_difffile_file_name.to_s
      puts "The b_difffile object is = " + b_difffile.to_s
      is_present = true
      return [is_present, b_difffile]
      break
    end
  end
  return [false, nil]
end


def ComparePatchForDifffiles(a, b)
  puts "------------------- BEGIN ComparePatchforDifffiles ----------------"
  a_additions = a.additions
  a_deletions = a.deletions

  b_additions = b.additions
  b_deletions = b.deletions

  puts "a_additions = " + a_additions.to_s
  puts "b_additions = " + b_additions.to_s
  puts "a_deletions = " + a_deletions.to_s
  puts "b_deletions = " + b_deletions.to_s
  c1 = a_additions == b_deletions
  c2 = a_deletions == b_additions

  puts c1
  puts c2
  puts "------------------- END ComparePatchforDifffiles ----------------"

  puts "WOW" if (c1 == true && c2 == true)
  if (c1 == true && c2 == true)
    return true
  else
    return false
  end
end

def CompareDiffPatch(a, b)
  a_numfiles = a.num_difffiles
  b_numfiles = b.num_difffiles

  unless a_numfiles == b_numfiles
    raise "Both stats must have the same number of files, \
        as we reached here only after checking stats and num_difffiles"
  end

  num_diffs_correct = 0
  a.difffiles.each do |a_difffile|
    a_difffile_file_name = a_difffile.file_name

    # Checkpoint #1 - The file_name must have a corresponding difffile in diff b
    is_present, b_difffile = GetCorrepondingDifffileInB(a_difffile_file_name, b)

    return false if is_present == false
    puts "is_present =" + is_present.to_s
    puts "b_difffile found for file_name = " + a_difffile_file_name + " is = " + b_difffile.to_s
    # Checkpoint #2 - Compare the patches for both difffiles a and b
    a_patch = a_difffile.patch
    b_patch = b_difffile.patch
    do_patches_match = ComparePatchForDifffiles(a_patch, b_patch)
    if do_patches_match == false
      return false
    else
      num_diffs_correct = num_diffs_correct + 1
    end
  end

  return true if num_diffs_correct == a_numfiles
end
