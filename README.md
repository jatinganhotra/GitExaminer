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
    Results on 23 open-source projects
  </a>
  The results are also provided below for a quick look.

<h6> Credits: </h6>

<p> This project was developed for CS 527 - Fall 2014 - University of Illinois at Urbana Champaign.
  Thanks to
  <a href="http://mir.cs.illinois.edu/marinov/">Darko Marinov</a>,
  <a href="http://mir.cs.illinois.edu/~eloussi2/">Lamyaa Eloussi</a> and
  <a href="http://mir.cs.illinois.edu/gliga/">Milos Gligoric</a>
  for providing feedback.
</p>

  <pre>
  
+----+---------------------------------------------------------+--------+--------+------+------+------+------+------+
|                                                      Results                                                      |
+----+---------------------------------------------------------+--------+--------+------+------+------+------+------+
| #  | ProjectName-                                            | #      | #      | #RV- | #RV- | #RV- | #CP- | #CP- |
|    | RepoURL-                                                | Commit | Merges | Msg  | Full | Part | Full | Part |
|    | HEAD SHA                                                |        |        |      |      |      |      |      |
+----+---------------------------------------------------------+--------+--------+------+------+------+------+------+
| 1  | backbone-fundamentals                                   | 1253   | 381    | 1    | 28   | 156  | 75   | 91   |
|    | https://github.com/addyosmani/backbone-fundamentals.git |        |        |      |      |      |      |      |
|    | 2ffeffdbc6196dd628fbf6305b8a4d609012ca4e                |        |        |      |      |      |      |      |

| 2  | catalyst-runtime                                        | 2832   | 114    | 26   | 33   | 177  | 42   | 198  |
|    | https://github.com/perl-catalyst/catalyst-runtime.git   |        |        |      |      |      |      |      |
|    | ee2c12fdbfa4662604cf07fa488b5c43c1e25b80                |        |        |      |      |      |      |      |

| 3  | jshint                                                  | 1454   | 245    | 5    | 7    | 247  | 43   | 174  |
|    | https://github.com/jshint/jshint.git                    |        |        |      |      |      |      |      |
|    | a643f3fec0632249dcd78d0cf5f200d9166b587d                |        |        |      |      |      |      |      |

| 4  | MLPNeuralNet                                            | 75     | 7      | 0    | 1    | 4    | 2    | 0    |
|    | https://github.com/nikolaypavlov/MLPNeuralNet           |        |        |      |      |      |      |      |
|    | a70d51708cd235bebbb9c4ef70aaab68d5c02b49                |        |        |      |      |      |      |      |

| 5  | mojo                                                    | 8924   | 88     | 16   | 44   | 143  | 13   | 67   |
|    | https://github.com/kraih/mojo.git                       |        |        |      |      |      |      |      |
|    | 24f5aafc27b0563253b3003d18b4ee3fe540b0ba                |        |        |      |      |      |      |      |

| 6  | ninja                                                   | 1266   | 227    | 3    | 40   | 179  | 85   | 119  |
|    | https://github.com/ninjaframework/ninja.git             |        |        |      |      |      |      |      |
|    | c6c87f85bceadb1af8234d2478971bbc890913c6                |        |        |      |      |      |      |      |

| 7  | sails                                                   | 4623   | 610    | 14   | 27   | 1132 | 163  | 962  |
|    | https://github.com/balderdashy/sails.git                |        |        |      |      |      |      |      |
|    | d433e3f39393fa15290f563385e1242317739578                |        |        |      |      |      |      |      |

| 8  | sinatra                                                 | 2648   | 441    | 21   | 44   | 352  | 175  | 151  |
|    | https://github.com/sinatra/sinatra.git                  |        |        |      |      |      |      |      |
|    | eb1acf2d8ecb365508f5d570c46893b2e97a460c                |        |        |      |      |      |      |      |

| 9  | stylus                                                  | 3613   | 481    | 9    | 14   | 242  | 295  | 923  |
|    | https://github.com/LearnBoost/stylus.git                |        |        |      |      |      |      |      |
|    | 7bf5cae588c2d27154356909e3f58170de7e8a42                |        |        |      |      |      |      |      |

| 10 | MapDB                                                   | 1079   | 41     | 6    | 9    | 34   | 17   | 13   |
|    | https://github.com/jankotek/MapDB.git                   |        |        |      |      |      |      |      |
|    | 1e3b272b31fbffcda393aa93f9666fac18c1dada                |        |        |      |      |      |      |      |

| 11 | codebox                                                 | 1913   | 93     | 4    | 6    | 67   | 10   | 38   |
|    | https://github.com/CodeboxIDE/codebox.git               |        |        |      |      |      |      |      |
|    | 8d1a79c07ea28626718e0c3a58a9fc3cc539a01c                |        |        |      |      |      |      |      |

| 12 | flockdb                                                 | 739    | 92     | 3    | 4    | 44   | 11   | 15   |
|    | https://github.com/twitter/flockdb.git                  |        |        |      |      |      |      |      |
|    | 3e35184203117eee28f7c0c147057cdea8969e5c                |        |        |      |      |      |      |      |

| 13 | lime                                                    | 858    | 156    | 3    | 7    | 104  | 27   | 56   |
|    | https://github.com/limetext/lime.git                    |        |        |      |      |      |      |      |
|    | 414943ddb105812b29e331af4ecb5c1422816d77                |        |        |      |      |      |      |      |

| 14 | neovim                                                  | 2237   | 327    | 6    | 9    | 141  | 36   | 68   |
|    | https://github.com/neovim/neovim.git                    |        |        |      |      |      |      |      |
|    | 68fcd8b696dae33897303c9f8265629a31afbf17                |        |        |      |      |      |      |      |

| 15 | pouchdb                                                 | 2367   | 281    | 24   | 27   | 199  | 23   | 149  |
|    | https://github.com/pouchdb/pouchdb.git                  |        |        |      |      |      |      |      |
|    | 02a37eca0741cd6b6eba8f19c608166f656b90f3                |        |        |      |      |      |      |      |

| 16 | redis                                                   | 4721   | 336    | 24   | 32   | 302  | 98   | 128  |
|    | https://github.com/antirez/redis.git                    |        |        |      |      |      |      |      |
|    | e039791e394fef936bf3582de80344e2eebf587b                |        |        |      |      |      |      |      |

| 17 | sharelatex                                              | 136    | 15     | 1    | 3    | 5    | 3    | 4    |
|    | https://github.com/sharelatex/sharelatex.git            |        |        |      |      |      |      |      |
|    | a4e5a5b713185b8d14122b6c1054cedeae0be33c                |        |        |      |      |      |      |      |

| 18 | slap                                                    | 296    | 0      | 0    | 0    | 0    | 1    | 0    |
|    | https://github.com/slap-editor/slap.git                 |        |        |      |      |      |      |      |
|    | 4fc4ba2dff6f2422c11407b35c653fcc2813a26f                |        |        |      |      |      |      |      |

| 19 | textmate                                                | 3262   | 4      | 21   | 13   | 11   | 1    | 2    |
|    | https://github.com/textmate/textmate.git                |        |        |      |      |      |      |      |
|    | 334b869639541501bdd87c4dac07d173adc7190b                |        |        |      |      |      |      |      |

| 20 | zed                                                     | 1100   | 186    | 7    | 11   | 151  | 39   | 105  |
|    | https://github.com/zedapp/zed.git                       |        |        |      |      |      |      |      |
|    | 2ef64f70d71aa8e377d2b843605700f77d973bd5                |        |        |      |      |      |      |      |

| 21 | couchdb                                                 | 5599   | 187    | 53   | 38   | 2442 | 32   | 3097 |
|    | https://github.com/apache/couchdb.git                   |        |        |      |      |      |      |      |
|    | 126ec7682020ad3c08966e4aef03ce02e9b14f7f                |        |        |      |      |      |      |      |

| 22 | orientdb                                                | 6773   | 893    | 50   | 59   | 1020 | 234  | 602  |
|    | https://github.com/orientechnologies/orientdb.git       |        |        |      |      |      |      |      |
|    | 0faf3c9c27febb4ed3469bec4fa309ca9e068f4b                |        |        |      |      |      |      |      |

| 23 | vim.js                                                  | 198    | 15     | 0    | 0    | 22   | 2    | 16   |
|    | https://github.com/coolwanglu/vim.js.git                |        |        |      |      |      |      |      |
|    | 45a2c231b1b38a34760b58ec2f0e20425605b5bd                |        |        |      |      |      |      |      |

+----+---------------------------------------------------------+--------+--------+------+------+------+------+------+

  </pre>

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

