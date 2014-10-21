RevertFinder
============

UIUC - Fall 2014 - How often do people revert code?
### Jatin Ganhotra | ganhotr2@illinois.edu | jatin.ganhotra@gmail.com

There is a diff associated with every commit. The diff contains a lot of information such as number of files changed, statistics such as # of additions/deletions to each file, actual changes to every file.  
When a programmer/developer does a `git revert CommitID`, the changes made for the CommitID are reverted back.
e.g. If a new line was added to file.txt with value a, then that change would be reverted.  

Reverts can be of 2 kinds: auto-revert and manual-revert. If there are no conflicts after revert, that's an auto-revert. The developer only needs to provide a commit message here. But, if there are conflicts after reverting the changes, then Git will display that there are conflicts. In this case, the developer would manually resolve the conflicts and the commit the change.  

It's easier to find auto-reverts, because the changes in the revert commit diff would be the exact reverse of when the CommitID happened.  But, it's difficult to accurately find manual-reverts or partial reverts, because the changes could be similar, but would not be an exact match.

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

