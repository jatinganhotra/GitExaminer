
# ----------------------------------------------------------------
# ------------------------ Install README ------------------------
# ----------------------------------------------------------------

The steps to setup the environment are as follows:

# Short version:
# Run these commands in the order mentioned:
# ----------------------------------------------------------------
    curl -sSL https://get.rvm.io | bash -s stable
    gem install specific_install rugged terminal-table awesome_print
    gem specific_install https://github.com/silverSpoon/ruby-git.git


# Longer version:
# A brief description of what each command does is provided as follows:
# ----------------------------------------------------------------
# 1. Install RVM Ruby Version Manager and latest Ruby
curl -sSL https://get.rvm.io | bash -s stable

# 2. Install gems/ libraries for git access, pretty printing and tabular output
gem install specific_install rugged terminal-table awesome_print

# 3. Install forked and updated version of ruby-git
# @https://github.com/silverSpoon/ruby-git
# The original version has 2 issues. I have fixed one issue
# and the fix is available in my repository
gem specific_install https://github.com/silverSpoon/ruby-git.git


# ----------------------------------------------------------------
# ---------------------- HOW TO Run ------------------------------
# ----------------------------------------------------------------

1. Clone the Project repository by
        git clone https://github.com/silverSpoon/GitExaminer.git
2. Run the project on a git repository by providing it
    a) the local git repository path
            ruby script.rb tests/test1
    b) or, pass the repository remote URL, e.g.
            ruby script.rb https://github.com/nikolaypavlov/MLPNeuralNet

    Execution steps:
    1. If input argument is repo remote URL, the project is cloned into the /tmp directory.
    2. Perform all the analysis
    3. Log the results into the respective files for reverts, merges, partial cherry-picks etc.
       in the Logs/ directory.
    4. Cleanup. Delete the cloned repository from /tmp

While executing and performing the analysis, information regarding the repository is printed
and also the progress in also printed to the screen, which tells how many commits have been
processed while looking for reverts, cherrypicks etc.

A typical execution run looks like:
⇒  ruby script.rb https://github.com/nikolaypavlov/MLPNeuralNet
 ---> Cloning your project repo. -> https://github.com/nikolaypavlov/MLPNeuralNet
 -------------------------------------------------
 Cloning into 'MLPNeuralNet'...
 remote: Counting objects: 364, done.
 remote: Total 364 (delta 0), reused 0 (delta 0)
 Receiving objects: 100% (364/364), 380.53 KiB | 0 bytes/s, done.
 Resolving deltas: 100% (185/185), done.
 Checking connectivity... done.
 -----------------------------
  ---> Gathering information about commits. Please wait............
# Commits = 75
# Commits with revert in message = 0
# of Merge Commits = 7
  -----------------------------
   ---> Looking for reverts - complete and partial & cherry-picks......
   Looked at # commits so far =
# 7 -> # 14 -> # 21 -> # 28 -> # 35 -> # 42 -> # 49 -> # 56 -> # 63 -> # 70 -> ......
# Reverts - complete = 1
# Reverts - partial  = 4
   -----------------------------
# Cherry-picks - complete = 2
# Cherry-picks - partial  = 0
   -----------------------------
    ---> One last touch, magic in-progress ............
    -----------------------------
     ---> The results are :-
     +--------------------------+-----------------------------------------------+
     |                           MLPNeuralNet-results                           |
     +--------------------------+-----------------------------------------------+
     |   ProjectName            | MLPNeuralNet                                  |
     |   RepoURL                | https://github.com/nikolaypavlov/MLPNeuralNet |
     |   HEAD SHA               | a70d51708cd235bebbb9c4ef70aaab68d5c02b49      |
     | # Commits                | 75                                            |
     | # Merges                 | 7                                             |
     | # Reverts - Message      | 0                                             |
     | # Reverts - Complete     | 1                                             |
     | # Reverts - Partial      | 4                                             |
     | # Cherrypicks - Complete | 2                                             |
     | # Cherrypicks - Partial  | 0                                             |
     +--------------------------+-----------------------------------------------+
