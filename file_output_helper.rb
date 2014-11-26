# ----------------------------------------------------------------------------------
# ---------------------   Output Complete Reverts   --------------------------------
# ----------------------------------------------------------------------------------
def OutputCompleteReverts( reverts_log_file_name, full_reverts, revert_diffs)
  if full_reverts > 0
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
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
      op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{diff.next_commit_sha}").message)
      op_file.puts("-----------------------------------------------------------------")
      op_file.puts "\n"
      num = num.succ
    end
  end
end

# ----------------------------------------------------------------------------------
# ----------------------   Output Partial Reverts   --------------------------------
# ----------------------------------------------------------------------------------
def OutputPartialReverts( partial_reverts_log_file_name, partial_reverts, partial_revert_diffs)
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
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
      op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{diff.next_commit_sha}").message)
      op_file.puts("The files with partial_reverts are:-")
      op_file.puts(partial_match)
      op_file.puts("-----------------------------------------------------------------")
      op_file.puts "\n"
      num = num.succ
    end
  end
end

# ----------------------------------------------------------------------------------
# ---------------------   Output Complete Cherry-picks   ---------------------------
# ----------------------------------------------------------------------------------
def OutputCompleteCherryPicks( full_cps_log_file_name, full_cps, cp_diffs)
  if full_cps > 0
    op_file = File.open(full_cps_log_file_name, "w")
    num = 1
    op_file.puts "# of cherry-picks = " + full_cps.to_s
    cp_diffs.each do |cherrypick_diff_pair|
      diff = cherrypick_diff_pair[:diff]
      cmp_diff = cherrypick_diff_pair[:cmp_diff]
      op_file.puts("Cherry-pick diff pair #{num} is -> ")
      op_file.puts("\{ #{cmp_diff.prev_commit_sha} -> #{cmp_diff.next_commit_sha} \} is a cherrypick")
      op_file.puts("\{ #{diff.prev_commit_sha} -> #{diff.next_commit_sha} \}")
      op_file.puts("Cherrypick commits SHA are -> ")
      op_file.puts("#{cmp_diff.next_commit_sha} - cherrypick - #{diff.next_commit_sha}")
      op_file.puts("The cherrypicked commit sha is - #{cmp_diff.next_commit_sha}")
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
      op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{diff.next_commit_sha}").message)
      op_file.puts("-----------------------------------------------------------------")
      op_file.puts "\n"
      num = num.succ
    end
  end
end

# ----------------------------------------------------------------------------------
# ----------------------   Output Partial Cherry-picks   ---------------------------
# ----------------------------------------------------------------------------------
def OutputPartialCherryPicks( partial_cherrypicks_log_file_name, partial_cps, partial_cp_diffs)
  if partial_cps > 0
    op_file = File.open(partial_cherrypicks_log_file_name, "w")
    num = 1
    op_file.puts "# of partial cherrypicks = " + partial_cherrypicks.to_s
    partial_cp_diffs.each do |partial_cherrypick_diff_pair, partial_match|
      diff = partial_cherrypick_diff_pair[:diff]
      cmp_diff = partial_cherrypick_diff_pair[:cmp_diff]
      op_file.puts("Partial Cherry-pick diff pair #{num} is -> ")
      op_file.puts("\{ #{cmp_diff.prev_commit_sha} -> #{cmp_diff.next_commit_sha} \} is a cherrypick")
      op_file.puts("\{ #{diff.prev_commit_sha} -> #{diff.next_commit_sha} \}")
      op_file.puts("Partial Cherry-pick commits SHA are -> ")
      op_file.puts("#{cmp_diff.next_commit_sha} - cherrypick - #{diff.next_commit_sha}")
      op_file.puts("The cherrypicked commit sha is - #{cmp_diff.next_commit_sha}")
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{cmp_diff.next_commit_sha}").message)
      op_file.puts("The original commit sha is - " + diff.next_commit_sha.to_s)
      op_file.puts("Commit message - " + $rugged_repo.lookup("#{diff.next_commit_sha}").message)
      op_file.puts("The files with partial_cherrypicks are:-")
      op_file.puts(partial_match)
      op_file.puts("-----------------------------------------------------------------")
      op_file.puts "\n"
      num = num.succ
    end
  end
end