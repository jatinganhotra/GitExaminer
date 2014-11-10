RevertFinder
============

How often do people revert code?
#### Jatin Ganhotra | ganhotr2@illinois.edu | jatin.ganhotra@gmail.com

There is a diff associated with every commit. A diff contains a lot of information such as # of files changed, statistics such as # of additions/deletions for each file and actual changes to every file.  
When a programmer/developer does a `git revert CommitID`, the changes made for the CommitID are reverted back.
e.g. If a new line was added to file.txt with value a, then that change would be reverted.  

Reverts can be of 2 kinds: auto-revert and manual-revert. If there are no conflicts after revert, that's an auto-revert. The developer only needs to provide a commit message here. But, if there are conflicts after reverting the changes, then Git will display that there are conflicts. In this case, the developer would manually resolve the conflicts and the commit the change.  

In an auto-revert, the changes in the revert commit diff are the exact opposite of when the CommitID happened.  But, it's difficult to accurately find manual-reverts or partial reverts, because the changes could be similar, but would not be an exact match.

#### Results  

|  # | Repo URL                                            | #Commits | SHA                                      | #RV(Message) | #RV(Content) |
|:--:|-----------------------------------------------------|----------|------------------------------------------|--------------|--------------|
| 1  | https://github.com/LearnBoost/stylus                | 3610     | d6d4fd5c48d8b4c7645b89229c7df3ec79cc8    | 9            | 14           |
| 2  | https://github.com/sinatra/sinatra                  | 2646     | 4e92d604be5269b1d6527a6093f112d10b5b9d7f | 21           | 44           |
| 3  | https://github.com/balderdashy/sails                | 4601     | 3f7b46d77cd3569d9b126350cc7a25b583695dc3 | 14           | 24           |
| 4  | https://github.com/ninjaframework/ninja             | 1266     | c6c87f85bceadb1af8234d2478971bbc890913c6 | 3            | 14           |
| 5  | https://github.com/kraih/mojo                       | 8859     | f711943f90498f16088acca28f62c40e603c2388 | 15           | 42           |
| 6  | https://github.com/jshint/jshint                    | 1396     | 1b886447c75b3164ccef95bd9236dbeb8d58950f | 5            | 6            |
| 7  | https://github.com/perl-catalyst/catalyst-runtime   | 2829     | f384c84887409fd343be4751b40a232ebf224b5c | 26           | 31           |
| 8  | https://github.com/cakephp/cakephp                  | 17266    | 279d15aaa582f7b8b283b556665d05afb1393690 | 87           | 106          |
| 9  | https://github.com/addyosmani/backbone-fundamentals | 1244     | 433b58f50650d0a44c7209ef5b3fa501f919b36a | 1            | 28           |
| 10 | https://github.com/nikolaypavlov/MLPNeuralNet       | 75       | a70d51708cd235bebbb9c4ef70aaab68d5c02b49 | 0            | 1            |

#### Modeling Git Commit History and Diffs

##### Gems used:  
[Ruby-Git](https://github.com/schacon/ruby-git)  
[Rugged](https://github.com/libgit2/rugged)  

##### Diff Object:  
Each diff object would have the following attributes - `diff, difffiles, num_difffiles, stats, prev_commit_sha, next_commit_sha`.  
`diff` - The entire diff object. *TODO*: Redundant, to be removed later.  
`difffiles` - An array of difffile objects  
`num_difffiles` - The number of difffile objects, used for quick comparison  
`stats` - Helpful statistics such as insertions, deletions, lines changed per file and total count for these parameters. e.g. _{:total=>{:insertions=>0, :deletions=>2, :lines=>2, :files=>2},:files=>{"file.txt"=>{:insertions=>0, :deletions=>1}, "file2.txt"=>{:insertions=>0, :deletions=>1}}}_. *TODO*: Push the individual file stats in the diffFile object.  
`prev_commit_sha` - The Git sha for the previous commit  
`next_commit_sha` - The Git sha for the next commit  

##### DiffFile Object:  
Each diffFile object would have the following attributes - `difffile, patch`  
`difffile` - The entire difffile object. *TODO*: Redundant, to be removed later.  
`patch` - The patch for the change. *TODO*: Break patch down further to additions and deletions for the difffile.  
*TODO*: Add file stats for the individual file from the Diff object stats parameter here.  

