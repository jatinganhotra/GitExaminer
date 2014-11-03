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
      ap a_file_stats
      a_insertions = a_file_stats[:insertions]
      a_deletions = a_file_stats[:deletions]
      puts "Insertions are - " + a_insertions.to_s
      puts "Deletions are - " +  a_deletions.to_s

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