require 'awesome_print'

def PrintDiffBWCommitsRugged(diff_bw_commit_trees)
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  puts "START -> DIff generated by rugged gem => "
  puts diff_bw_commit_trees
  puts diff_bw_commit_trees.patch
  puts "END -> DIff generated by rugged gem => "
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
end

def PrintDiffBWCommitsRubyGit(diff_bw_commits)
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
  puts "START -> DIff generated by ruby-git gem => "
  puts diff_bw_commits
  puts "END -> DIff generated by ruby-git gem => "
  puts "^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^"
end

# Input arguments are diff, cmp_diff
def PrintDiffInfoAndStats(diff,cmp_diff)
  puts "********** PrintDiffInfoAndStats BEGIN ***********"
  puts "diff stats is = \n"
  ap diff.stats
  puts "diff sha's are = "
  puts("\{ #{diff.prev_commit_sha} -> #{diff.next_commit_sha} \}")
  puts "diff prev commit message is "
  puts $rugged_repo.lookup(diff.prev_commit_sha).message
  puts "diff next commit message is "
  puts $rugged_repo.lookup(diff.next_commit_sha).message
  puts "--------------------------------------------------"

  puts "cmp_diff stats is = \n"
  ap cmp_diff.stats
  puts "cmp_diff sha's are = "
  puts("\{ #{cmp_diff.prev_commit_sha} -> #{cmp_diff.next_commit_sha} \}")
  puts "cmp_diff prev commit message is "
  puts $rugged_repo.lookup(cmp_diff.prev_commit_sha).message
  puts "cmp_diff next commit message is "
  puts $rugged_repo.lookup(cmp_diff.next_commit_sha).message
  puts "--------------------------------------------------"
  puts "********** PrintDiffInfoAndStats END **************"
end