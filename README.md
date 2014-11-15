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
i+---+-----------------------+---------------------------------------------------------+--------+------+-------+------+
|                                                      Results                                                       |
+---+-----------------------+---------------------------------------------------------+--------+------+-------+------+
| # | ProjectName           | RepoURL-                                                | #      | #RV  | #RV   | #RV- |
|   |                       | HEAD SHA                                                | Commit | -Msg | -Full | Part |
+---+-----------------------+---------------------------------------------------------+--------+------+-------+------+
| 1 | backbone-fundamentals | https://github.com/addyosmani/backbone-fundamentals.git | 1251   | 1    | 28    | 156  |
|   |                       | f4dc7848c85faa31af853a9c4c2c6562310f0c02                |        |      |       |      |

| 2 | catalyst-runtime      | https://github.com/perl-catalyst/catalyst-runtime.git   | 2831   | 26   | 33    | 177  |
|   |                       | 5bec3c066856eaf822d757d6c8295276ddb9d281                |        |      |       |      |

| 3 | jshint                | https://github.com/jshint/jshint.git                    | 1438   | 5    | 7     | 245  |
|   |                       | d0b3cfd935c9445f14b37ea9694d8a172a52739a                |        |      |       |      |

| 4 | MLPNeuralNet          | https://github.com/nikolaypavlov/MLPNeuralNet           | 75     | 0    | 1     | 4    |
|   |                       | a70d51708cd235bebbb9c4ef70aaab68d5c02b49                |        |      |       |      |

| 5 | mojo                  | https://github.com/kraih/mojo.git                       | 8872   | 15   | 43    | 142  |
|   |                       | 42c388f0c2a3fb6aae1a7bcd0bdb8504fe2a53df                |        |      |       |      |

| 6 | ninja                 | https://github.com/ninjaframework/ninja.git             | 1266   | 3    | 40    | 179  |
|   |                       | c6c87f85bceadb1af8234d2478971bbc890913c6                |        |      |       |      |

| 7 | sails                 | https://github.com/balderdashy/sails.git                | 4612   | 14   | 27    | 1131 |
|   |                       | c7e122aede533716fee0c5f6fb331cf64d4aad81                |        |      |       |      |

| 8 | sinatra               | https://github.com/sinatra/sinatra.git                  | 2646   | 21   | 44    | 352  |
|   |                       | 4e92d604be5269b1d6527a6093f112d10b5b9d7f                |        |      |       |      |

| 9 | stylus                | https://github.com/LearnBoost/stylus.git                | 3613   | 9    | 14    | 242  |
|   |                       | 7bf5cae588c2d27154356909e3f58170de7e8a42                |        |      |       |      |

+---+-----------------------+---------------------------------------------------------+--------+------+-------+------+

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

