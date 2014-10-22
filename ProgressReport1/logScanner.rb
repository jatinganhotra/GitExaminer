require 'rubygems'
require 'logger'
require 'git'

working_dir = `pwd`
g = Git.open(working_dir.chomp, :log => Logger.new(STDOUT))

# Get all the commits for the project
commits = g.log(nil)
revert_commits = []
commits.each do |commit|
  if commit.message.include? 'revert'
    revert_commits << commit
  end
end

revert_commits.each do |rc|
  puts rc.message
end

#puts revert_commits
puts revert_commits.count
puts commits.count

puts "The percentage of revert commits is = " + (revert_commits.count * 100.0 / commits.count ).to_s



