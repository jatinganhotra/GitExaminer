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
