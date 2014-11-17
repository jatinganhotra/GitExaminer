RevertFinder
============

<strong>
How often do people revert code?

<a name="jatin-ganhotra--ganhotr2illinoisedu--jatinganhotragmailcom" class="anchor" href="http://jatinganhotra.com"><span class="octicon octicon-link"></span>Jatin Ganhotra</a> | <a href="mailto:ganhotr2@illinois.edu">ganhotr2@illinois.edu</a> | <a href="mailto:jatin.ganhotra@gmail.com">jatin.ganhotra@gmail.com</a>
</strong>


<h6> Motivation: </h6>

<p> As developers, we always end up in situations when we realise a previous change was incorrect.
  Thanks to modern version control systems, such as <a href="http://git-scm.com">Git</a>,
  reverting the previous change is just one-command away.
  This project aims to find the # of reverts performed in a given project, given it's commit history.
</p>

<h6> Introduction: </h6>

<p>When a programmer/developer performs a <a href="http://git-scm.com/docs/git-revert">git-revert</a>
  by <code>git revert CommitID</code></p>

<p> Using the <code>git revert CommitID</code> command, the changes made for the <i>CommitID</i>
  are reverted back and updates applied to all the files in the CommitID are reversed.
</p>
<p>
  However, it's also possible that updates to only a subset of the files are reversed.
  It's hard to identify such cases with precision, but a study of how frequently such cases occur sounds
  interesting.
</p>

<p> We name such cases as <u><strong>Partial reverts</strong></u>, as only a subset of files were reverted.

<h6> How to identify full reverts and partial reverts? </h6>

<p>There is a diff associated with every commit. The diff contains a lot of information such as # of files
  changed, statistics such as # of additions/deletions for each file and actual changes to every file.<br></p>

<p> We mine this information and then identify reverts using an efficient search and comparison algorithm.</p>

<h6> Results: </h6>

  The results for some of the open-sourced projects are provided at: <br/>
  <a href="https://github.com/silverSpoon/RevertFinder/blob/master/results.txt">
    Results on 10 open-source projects
  </a>

<!--
<p>Reverts can be of 2 kinds: auto-revert and manual-revert.
  If there are no conflicts after revert, that's an auto-revert.
  The developer only needs to provide a commit message here.
  But, if there are conflicts after reverting the changes, then Git will display that there are conflicts.
  In this case, the developer would manually resolve the conflicts and the commit the change.
</p>

<p>In an auto-revert, the changes in the revert commit diff are the exact opposite of when
  the CommitID happened.  But, it's difficult to accurately find manual-reverts or partial
  reverts, because the changes could be similar, but would note an exact match.
</p>
-->

<h6> Credits: </h6>

<p> This project was developed for CS 527 - Fall 2014 - University of Illinois at Urbana Champaign.
  Thanks to
  <a href="http://mir.cs.illinois.edu/marinov/">Darko Marinov</a>,
  <a href="http://mir.cs.illinois.edu/~eloussi2/">Lamyaa Eloussi</a> and
  <a href="http://mir.cs.illinois.edu/gliga/">Milos Gligoric</a>
  for providing feedback.
</p>
