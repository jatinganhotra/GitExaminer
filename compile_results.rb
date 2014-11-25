require 'terminal-table'

# The results file looks like -
# +----------------------+-----------------------------------------------+
# |                         MLPNeuralNet-results                         |
# +----------------------+-----------------------------------------------+
# |   ProjectName        | MLPNeuralNet                                  |
# |   RepoURL            | https://github.com/nikolaypavlov/MLPNeuralNet |
# |   HEAD SHA           | a70d51708cd235bebbb9c4ef70aaab68d5c02b49      |
# | # Commits            | 75                                            |
# | # Reverts - Message  | 0                                             |
# | # Reverts - Complete | 1                                             |
# | # Reverts - Partial  | 4                                             |
# +----------------------+-----------------------------------------------+


def ExtractInfoFromFileContents file_contents
data = file_contents.split('|')
# Remove the first line
# Remove the project_name from data
# Remove the line below project_name
data = data.drop(3)

# Now, everything is in 3-tuple <key, value, "\n">
data.shift
project_name = data.first
project_name = project_name.gsub(/\s+/, "")
data = data.drop(3)

repo_url = data.first
repo_url = repo_url.gsub(/\s+/, "")
data = data.drop(3)

head_sha = data.first
head_sha = head_sha.gsub(/\s+/, "")
data = data.drop(3)

num_commits = data.first
num_commits = num_commits.gsub(/\s+/, "")
data = data.drop(3)

reverts_msg = data.first
reverts_msg = reverts_msg.gsub(/\s+/, "")
data = data.drop(3)

reverts_complete = data.first
reverts_complete = reverts_complete.gsub(/\s+/, "")
data = data.drop(3)

reverts_partial = data.first
reverts_partial = reverts_partial.gsub(/\s+/, "")
data = data.drop(2)

repo_url_head_sha_combined = repo_url + "\n" + head_sha
return [project_name, repo_url_head_sha_combined, num_commits, reverts_msg, reverts_complete, reverts_partial]

end

results_file_name = "results.txt"
op_file = File.open(results_file_name, "w")
rows = []
num = 0

# Compiling results in a specific order to easily identify any changes
#Dir.foreach("RevertLogs")  do |file|
projects = ["backbone-fundamentals", "catalyst-runtime", "jshint", "MLPNeuralNet", "mojo", "ninja", "sails", "sinatra", "stylus", "MapDB", "codebox", "flockdb", "lime", "neovim", "pouchdb", "redis", "sharelatex", "slap", "textmate", "zed", "couchdb", "orientdb", "vim.js"]
projects.each do |file|
  file = file + "-results.txt"
  next if file.match(/.*-results.txt$/).nil?

  complete_file_name = "RevertLogs/" + file.to_s
  f = File.open("#{complete_file_name}", "r")
  info = ExtractInfoFromFileContents(f.read)
  num = num.succ

  info.insert(0, num)
  rows << info
  rows << ["","","","","","",""]
end

table = Terminal::Table.new :title => "Results", :headings => ['#', 'ProjectName', "RepoURL-\nHEAD SHA", "#\nCommit", "#RV\n-Msg" , "#RV\n-Full", "#RV-\nPart"], :rows => rows
puts table
op_file.puts table
