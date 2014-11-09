require 'rubygems'
require 'logger'
require 'rugged'
require 'git'
require 'awesome_print'

# Include diff, difffile classes
load 'diff.rb'
load 'difffile.rb'
load 'helper.rb'
load 'debug_helper.rb'

# Send console output to console.out
$stdout.reopen("console.out", "w")
$stdout.sync = true
$stderr.reopen($stdout)

# Global array to store all the diffs
diffs_array = []

# Initialize both libraries
git_repo_path = ARGV[0]
rubygit_gem_repo = Git.open(git_repo_path, :log => Logger.new(STDOUT))
rugged_repo = Rugged::Repository.new(git_repo_path)

# Get all the commits for the project
commit_list = rubygit_gem_repo.log(nil)
commit_list_array = commit_list.to_a
commit_list_array.reverse!

# ----------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------

# FIXME: Somehow this always gives errors. Get the initial empty tree state
#empty_tree=`git hash-object -w -t tree /dev/null`
#empty_state = rugged_repo.lookup("#{empty_tree.chomp}")
#commit_list_array.insert(0, empty_state)

# FIXME: Change this line to find reverts only in a subset of commits
num_commits = commit_list_array.size
start_target_history_count = (ARGV[1].nil? == false) ? ARGV[1].to_i : 0
end_target_history_count = (ARGV[2].nil? == false) ? ARGV[2].to_i : num_commits - 1

for i in start_target_history_count...end_target_history_count
  prev_commit = commit_list_array[i]
  next_commit = commit_list_array[i+1]

  # Special handling for empty-tree state, as it's generated by Rugged API
  # So, there is no SHA field, rather an OID field
  prev_sha = ( prev_commit.respond_to?("sha") ) ? prev_commit.sha : prev_commit.oid
  next_sha = next_commit.sha

  # Using the ruby-git gem for diff between commits
  diff_bw_commits = rubygit_gem_repo.diff(prev_sha, next_sha)

  # FIXME: Can use Rugged gem for calculating diffs. Remember that the Rugged Gem doesn't provide stats for each diff
  # rugged_prev_commit = rugged_repo.lookup(prev_sha)
  # rugged_next_commit = rugged_repo.lookup(next_sha)
  # rugged_prev_commit_tree = rugged_prev_commit.tree
  # rugged_next_commit_tree = rugged_next_commit.tree
  # diff_bw_commit_trees = rugged_prev_commit_tree.diff(rugged_next_commit_tree)
  # PrintDiffBWCommitsRugged(diff_bw_commit_trees)
  # diff = Diff.new(prev_sha, next_sha, diff_bw_commit_trees.patch)

  # PrintDiffBWCommitsRubyGit(diff_bw_commits)

  diff = Diff.new(prev_sha, next_sha, diff_bw_commits)
  diff.generate_difffiles_and_stats
  diffs_array << diff
end

# ----------------------------------------------------------------------------------
# ------------------      CHECK FOR REVERTS       ----------------------------------
# ----------------------------------------------------------------------------------

difffile_name_num_reverts = 0

# The final answer - Array of diff pairs
revert_diffs = []

# Keep a hash for the diff_pair that you have visited so far
# If you have 4 commits, you'll have 3 diffs say 1,2,3
# You will have combinations
# (3,1), (3,2), (3,3)
# (2,1), (2,2), (2,3)
# (1,1), (1,2), (1,3)
# We should not look at (1,3) once we've visited (3,1)
# and but obvious, dont look at (1,1), (2,2) and (3,3)
visited = {}

diffs_array.reverse_each do |diff|
  # For each diff starting from the latest, start comparison with the first
  diffs_array.each do |cmp_diff|
    next if diff == cmp_diff # No point looking at the same diff

    # Checkpoint #1 - Number of difffiles should be equal
    # FIXME: The below raise shoild be present
    #raise "num_difffiles must not be 0" if diff.num_difffiles == 0 || cmp_diff.num_difffiles == 0

    next if diff.num_difffiles != cmp_diff.num_difffiles

    diff_pair = [diff, cmp_diff].sort!
    # If you have already visited this pair, don't work again on it
    next if visited[diff_pair] == true

    # Mark this diff_pair as visited
    visited[diff_pair] = true

    # Checkpoint #2 - Compare stats first before comparing content
    # Check if stats are not nil
    PRINT_AND_EXIT(diff, cmp_diff, {:stats => true})
    stats_match = CompareDiffStats(diff.stats, cmp_diff.stats)
    # Continue when the stats don't match
    next if stats_match == false

    patch_match = CompareDiffPatch(diff, cmp_diff)
    if patch_match == true
      difffile_name_num_reverts = difffile_name_num_reverts + 1
      #puts "==================================   BEGIN ================================================"
      #puts "--- PATCH MATCH - Yes the patches match !! The revert commits are - "
      #puts ">> The commit sha for this diff is - " + diff.next_commit_sha.to_s
      #puts ">> The commit message for this diff is - " + rugged_repo.lookup("#{diff.next_commit_sha}").message
      #puts ">> The reverted commit sha is - " + cmp_diff.next_commit_sha.to_s
      #puts ">> The commit message for this diff is - " + rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message
      #puts "==================================   END  ================================================"
      revert_diff_pair = {}
      revert_diff_pair[:diff] = diff
      revert_diff_pair[:cmp_diff] = cmp_diff
      revert_diffs << revert_diff_pair
    end
  end
end

op_file = File.open("output", "w")
num = 1
op_file.puts "# of reverts = " + difffile_name_num_reverts.to_s
revert_diffs.each do |revert_diff_pair|
  diff = revert_diff_pair[:diff]
  cmp_diff = revert_diff_pair[:cmp_diff]
  op_file.puts("Revert diff pair #{num} is -> ")
  op_file.puts("\{ #{cmp_diff.prev_commit_sha} -> #{cmp_diff.next_commit_sha} \} is a revert")
  op_file.puts("\{ #{diff.prev_commit_sha} -> #{diff.next_commit_sha} \}")
  op_file.puts("Revert commits SHA are -> ")
  op_file.puts("#{cmp_diff.next_commit_sha} - revert - #{diff.next_commit_sha}")
  op_file.puts("The reverted commit sha is - #{cmp_diff.next_commit_sha}")
  op_file.puts("Commit message - " + rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
  op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
  op_file.puts("Commit message - " + rugged_repo.lookup("#{diff.next_commit_sha}").message)
  op_file.puts("-----------------------------------------------------------------")
  op_file.puts "\n"
  num = num.succ
end