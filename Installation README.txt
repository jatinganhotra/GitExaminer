
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
