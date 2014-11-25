require 'rubygems'
require 'logger'
require 'rugged'
require 'git'
require 'awesome_print'
require 'terminal-table'

# Include diff, difffile classes
load 'diff.rb'
load 'difffile.rb'
load 'helper.rb'
load 'debug_helper.rb'

# Global array to store all the diffs
diffs_array = []

orig_path = Dir.pwd

git_repo_url = ARGV[0]
project_name = git_repo_url.split('/')
project_name = project_name.last
# When you pass a repo_URL like https://github.com/jshint/jshint.git
# You need to take away the .git part too
project_name = project_name.split('.')
project_name = project_name.first

# Tip: To try on local git repo, just comment the below code
#git_repo_path = ARGV[0]
puts " ---> Cloning your project repo. -> " + git_repo_url.to_s
puts "-------------------------------------------------"
Dir.chdir "/tmp"
system("rm -rf #{project_name}")
system("git clone #{git_repo_url}")
puts "-----------------------------"
git_repo_path = "/tmp/" + project_name.to_s

# Send console output to console.out
Dir.chdir "#{orig_path}"
stdout_filename = "RevertLogs/" + project_name + "-console.log"
# Keep a dup of STDOUT for later use
old_stdout = $stdout.dup
$stdout.reopen(stdout_filename, "w")

# Initialize both libraries
rubygit_gem_repo = Git.open(git_repo_path, :log => Logger.new(STDOUT))
rugged_repo = Rugged::Repository.new(git_repo_path)

head_commit = rubygit_gem_repo.log(1)
head_commit = head_commit.to_a
head_commit = head_commit[0]
head_commit_sha = head_commit.sha

# Get all the commits for the project
commit_list = rubygit_gem_repo.log(nil)
commit_list_array = commit_list.to_a
commit_list_array.reverse!

# Calculate the # of total commits
num_commits = commit_list_array.count

# Calculate the number of commits which have revert in their message
msg_revert_commits = []
commit_list_array.each do |commit|
  if commit.message.include? 'revert'
    msg_revert_commits << commit
  end
end
num_commits_revert_msg = msg_revert_commits.count

# ----------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------

# FIXME: Working around the initial empty tree state
#empty_tree=`git hash-object -w -t tree /dev/null`
#empty_state = rugged_repo.lookup("#{empty_tree.chomp}")
#commit_list_array.insert(0, empty_state)

$stdout = old_stdout.dup
print " ---> Gathering information about commits. Please wait."
10.times { print "." ; sleep(1.0/10)} ; puts "."
puts "# Commits = " + num_commits.to_s
puts "# Commits with revert in message = " + num_commits_revert_msg.to_s
puts "-----------------------------"
print " ---> Looking for reverts - complete and partial ."
5.times { print "." ; sleep(1.0/10)}
$stdout.reopen(stdout_filename, "w")

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

$stdout = old_stdout.dup
5.times { print "." ; sleep(1.0/10)} ; puts "."
$stdout.reopen(stdout_filename, "w")

full_reverts = 0
partial_reverts = 0

# The final answer - Array of diff pairs
revert_diffs = []
partial_revert_diffs = []

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
    # FIXME: This still causes issues when running on projects
    # raise "num_difffiles must not be 0" if diff.num_difffiles == 0 || cmp_diff.num_difffiles == 0
    next if diff.num_difffiles == 0 || cmp_diff.num_difffiles == 0

    # TODO - Enhancement for partial reverts
    #next if diff.num_difffiles != cmp_diff.num_difffiles

    diff_pair = [diff, cmp_diff].sort!
    # If you have already visited this pair, don't work again on it
    next if visited[diff_pair] == true

    # Mark this diff_pair as visited
    visited[diff_pair] = true

    # Checkpoint #2 - Compare stats first before comparing content
    # Check if stats are not nil
    # PRINT_AND_EXIT(diff, cmp_diff, {:stats => true})
    # stats_match = CompareDiffStats(diff.stats, cmp_diff.stats)
    # Continue when the stats don't match
    # TODO - Enhancement for partial reverts
    # next if stats_match == false

    match, partial_match = CompareDiffPatch(diff, cmp_diff)
    if match == true
      # Case 1: Full revert
      if partial_match.nil?
        full_reverts = full_reverts + 1
        revert_diff_pair = {}
        revert_diff_pair[:diff] = diff
        revert_diff_pair[:cmp_diff] = cmp_diff
        revert_diffs << revert_diff_pair
      else
        partial_reverts = partial_reverts + 1
        partial_revert_diff_pair = {}
        partial_revert_diff_pair[:diff] = diff
        partial_revert_diff_pair[:cmp_diff] = cmp_diff
        partial_revert_diffs << [ partial_revert_diff_pair, partial_match ]
      end
    end
  end
end

$stdout = old_stdout.dup
puts "# Reverts - complete = " + full_reverts.to_s
puts "# Reverts - partial  = " + partial_reverts.to_s
puts "-----------------------------"
$stdout.reopen(stdout_filename, "w")

# ----------------------------------------------------------------------------------
# ---------------------   Output Complete Reverts   --------------------------------
# ----------------------------------------------------------------------------------

reverts_log_file_name         = "RevertLogs/" + project_name + "-reverts.log"

op_file = File.open(reverts_log_file_name, "w")
num = 1
op_file.puts "# of reverts = " + full_reverts.to_s
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

# ----------------------------------------------------------------------------------
# ----------------------   Output Partial Reverts   --------------------------------
# ----------------------------------------------------------------------------------

partial_reverts_log_file_name = "RevertLogs/" + project_name + "-partial-reverts.log"

if partial_reverts > 0
  op_file = File.open(partial_reverts_log_file_name, "w")
  num = 1
  op_file.puts "# of partial reverts = " + partial_reverts.to_s
  partial_revert_diffs.each do |partial_revert_diff_pair, partial_match|
    diff = partial_revert_diff_pair[:diff]
    cmp_diff = partial_revert_diff_pair[:cmp_diff]
    op_file.puts("Partial Revert diff pair #{num} is -> ")
    op_file.puts("\{ #{cmp_diff.prev_commit_sha} -> #{cmp_diff.next_commit_sha} \} is a revert")
    op_file.puts("\{ #{diff.prev_commit_sha} -> #{diff.next_commit_sha} \}")
    op_file.puts("Partial Revert commits SHA are -> ")
    op_file.puts("#{cmp_diff.next_commit_sha} - revert - #{diff.next_commit_sha}")
    op_file.puts("The reverted commit sha is - #{cmp_diff.next_commit_sha}")
    op_file.puts("Commit message - " + rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
    op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
    op_file.puts("Commit message - " + rugged_repo.lookup("#{diff.next_commit_sha}").message)
    op_file.puts("The files with partial_reverts are:-")
    op_file.puts(partial_match)
    op_file.puts("-----------------------------------------------------------------")
    op_file.puts "\n"
    num = num.succ
  end
end

# ----------------------------------------------------------------------------------
# ----------------------------   Output All Results --------------------------------
# ----------------------------------------------------------------------------------

$stdout = old_stdout.dup
print " ---> One last touch, magic in-progress ."
10.times { print "." ; sleep(1.0/10)} ; puts "."
puts "-----------------------------"
puts " ---> The results are :-"

results_file_name = "RevertLogs/" + project_name + "-results.txt"
op_file = File.open(results_file_name, "w")

# The below representation might be useful when you have multiple projects
#rows << [ project_name, git_repo_url, head_commit_sha, num_commits, num_commits_revert_msg, full_reverts, partial_reverts]
#table = Terminal::Table.new :headings => ['ProjectName', 'RepoURL', 'SHA', '#Commits', 'RVMsg', '#RVFull', '#RVPartial'], :rows => rows
rows = []
rows << [ '  ProjectName', project_name ]
rows << [ '  RepoURL', git_repo_url ]
rows << [ '  HEAD SHA', head_commit_sha ]
rows << [ '# Commits', num_commits ]
rows << [ '# Reverts - Message', num_commits_revert_msg ]
rows << [ '# Reverts - Complete', full_reverts ]
rows << [ '# Reverts - Partial', partial_reverts ]
table = Terminal::Table.new :title => "#{project_name}-results", :rows => rows
puts table
op_file.puts table

# ----------------------------------------------------------------------------------
# ----------------------------------   Cleanup -------------------------------------
# ----------------------------------------------------------------------------------

Dir.chdir "/tmp"
system("rm -rf #{project_name}")
