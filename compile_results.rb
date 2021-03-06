require 'terminal-table'

# The results file looks like -
# +--------------------------+-----------------------------------------------+
# |                           MLPNeuralNet-results                           |
# +--------------------------+-----------------------------------------------+
# |   ProjectName            | MLPNeuralNet                                  |
# |   RepoURL                | https://github.com/nikolaypavlov/MLPNeuralNet |
# |   HEAD SHA               | a70d51708cd235bebbb9c4ef70aaab68d5c02b49      |
# | # Commits                | 75                                            |
# | # Merges                 | 7                                             |
# | # Reverts - Message      | 0                                             |
# | # Reverts - Complete     | 1                                             |
# | # Reverts - Partial      | 4                                             |
# | # Cherrypicks - Complete | 2                                             |
# | # Cherrypicks - Partial  | 0                                             |
# +--------------------------+-----------------------------------------------+

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

num_merges = data.first
num_merges = num_merges.gsub(/\s+/, "")
data = data.drop(3)

reverts_msg = data.first
reverts_msg = reverts_msg.gsub(/\s+/, "")
data = data.drop(3)

reverts_complete = data.first
reverts_complete = reverts_complete.gsub(/\s+/, "")
data = data.drop(3)

reverts_partial = data.first
reverts_partial = reverts_partial.gsub(/\s+/, "")
data = data.drop(3)

cps_complete = data.first
cps_complete = cps_complete.gsub(/\s+/, "")
data = data.drop(3)

cps_partial = data.first
cps_partial = cps_partial.gsub(/\s+/, "")
data = data.drop(2)

project_name_repo_url_head_sha_combined = project_name + "\n" + repo_url + "\n" + head_sha
return [project_name_repo_url_head_sha_combined, num_commits, num_merges, reverts_msg, reverts_complete, reverts_partial, cps_complete, cps_partial]

end

results_file_name = "results.txt"
op_file = File.open(results_file_name, "w")
rows = []
num = 0

# Compiling results in a specific order to easily identify any changes
projects = ["backbone-fundamentals", "catalyst-runtime", "jshint", "MLPNeuralNet", "mojo", "ninja", "sails", "sinatra", "stylus", "MapDB", "codebox", "flockdb", "lime", "neovim", "pouchdb", "redis", "sharelatex", "slap", "textmate", "zed", "couchdb", "orientdb", "vim.js", "moloch", "ossec-hids", "cuckoo", "brakeman", "sleuthkit", "mig", "MozDef", "hoosegow", "backbone", "ember.js", "knockout", "todomvc", "spine", "polymer", "brick", "rubocop", "hlint", "coffeelint", "csslint", "scss-lint", "shellcheck", "puppet-lint", "eslint", "oclint", "toaruos", "phaser", "melonJS", "Crafty", "cocos2d-html5", "engine", "panda.js"]
projects.each do |file|
  file = file + "-results.txt"
  next if file.match(/.*-results.txt$/).nil?

  complete_file_name = "Logs/" + file.to_s
  f = File.open("#{complete_file_name}", "r")
  info = ExtractInfoFromFileContents(f.read)
  num = num.succ

  info.insert(0, num)
  rows << info
  rows << ["","","","","","","","",""]
end

table = Terminal::Table.new :title => "Results", :headings => ['#', "ProjectName-\nRepoURL-\nHEAD SHA", "#\nCommit", "#\nMerges", "#RV-\nMsg" , "#RV-\nFull", "#RV-\nPart", "#CP-\nFull", "#CP-\nPart"], :rows => rows
puts table
op_file.puts table
