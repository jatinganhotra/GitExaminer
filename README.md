GitExaminer
============

<strong>
How often do people revert/merge/cherry-pick?

<a name="jatin-ganhotra--ganhotr2illinoisedu--jatinganhotragmailcom" class="anchor" href="http://jatinganhotra.com"><span class="octicon octicon-link"></span>Jatin Ganhotra</a> | <a href="mailto:ganhotr2@illinois.edu">ganhotr2@illinois.edu</a> | <a href="mailto:jatin.ganhotra@gmail.com">jatin.ganhotra@gmail.com</a>
</strong>


<h5> Motivation: </h5>

As developers, we come across different situations, such as:  
    * when we realise a previous change was incorrect, or  
    * when we need to cherry-pick a commit from one branch and apply it on another, or  
    * merge changes from one branch to another  


  Thanks to modern version control systems, such as <a href="http://git-scm.com">Git</a>,
  reverting the previous change, cherry-picking and merging are just one-command away.
  For any collaborative project, <i>revert</i>, <i>cherry-pick</i> and <i>merge</i> are
  essential.

<p>
  <strong>Git-Examiner</strong> reports the # of reverts, # of merges and # of cherry-picks performed in a given project, given it's commit history.<br/>
  In addition, Git-Examiner also inspects the commit history and also reports partial reverts and partial cherry-picks in the project.
</p>

<h5> Introduction: </h5>

<h6> Reverts & Partial Reverts </h6>
<p>A developer performs a <a href="http://git-scm.com/docs/git-revert">git-revert</a>
  by <code>git revert CommitID</code></p>

<p> Using the <code>git revert CommitID</code> command, the changes made for the <i>CommitID</i>
  are reverted back and updates applied to all the files in the CommitID are reversed.
</p>
<p>
  However, it's also possible that updates to only a subset of the files are reversed.
  We refer to such cases as <u>Partial reverts</u>, as only a subset of files were reverted.
  Git-Examiner reports all partial reverts along with the file names.
</p>


<h6> Cherry-picks & Partial Cherry-picks </h6>
<p>A developer performs a <a href="http://git-scm.com/docs/git-cherry-pick">git-cherry-pick</a>
  by <code>git cherry-pick CommitID</code></p>

<p> Using the <code>git cherry-pick CommitID</code> command, the changes introduced by the <i>CommitID</i>
  are applied and a new commit is created with these changes. Note that the <i>CommitID</i> refers to a
  change introduced on a different branch.
</p>
<p>
  However, it's also possible that the same updates are applied but to only a subset of the files.
  We refer to such cases as <u>Partial Cherry-picks</u>, as only a subset of files had the same changes introduced.
  Git-Examiner reports all partial cherry-picks along with the file names.
</p>

<h5> How to identify Reverts/ Partial reverts/ Cherry-picks/ Partial cherry-picks & Merges? </h5>

<p>There is a diff associated with every commit. The diff contains a lot of information such as # of files
  changed, statistics such as # of additions/deletions for each file and actual changes to every file.<br></p>

<p> We mine this information and then identify reverts using an efficient search and comparison algorithm.</p>

<h5> Results: </h5>

  The results for some of the open-sourced projects are provided at: <br/>
  <a href="https://github.com/silverSpoon/RevertFinder/blob/master/results.txt">
    Results on 54 open-source projects
  </a>
  The results are also provided below for a quick look.

<h5> Credits: </h5>

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

| 24 | moloch                                                  | 431    | 15     | 0    | 0    | 7    | 4    | 2    |
|    | https://github.com/aol/moloch.git                       |        |        |      |      |      |      |      |
|    | 70dd5aa6181fb096be644c0dcc1e0103cbc02677                |        |        |      |      |      |      |      |

| 25 | ossec-hids                                              | 3499   | 399    | 8    | 35   | 277  | 57   | 261  |
|    | https://github.com/ossec/ossec-hids.git                 |        |        |      |      |      |      |      |
|    | db0197df7a577d6d1b7b4fc34ce771d56a268e4e                |        |        |      |      |      |      |      |

| 26 | cuckoo                                                  | 2839   | 327    | 39   | 33   | 325  | 80   | 149  |
|    | https://github.com/cuckoobox/cuckoo.git                 |        |        |      |      |      |      |      |
|    | 9a34ecb6943c229bc75850ed29bdf329c78ad746                |        |        |      |      |      |      |      |

| 27 | brakeman                                                | 2103   | 385    | 4    | 14   | 196  | 62   | 139  |
|    | https://github.com/presidentbeef/brakeman.git           |        |        |      |      |      |      |      |
|    | 36cdce51d31f89d137bd891f4f082d8abeebded5                |        |        |      |      |      |      |      |

| 28 | sleuthkit                                               | 3291   | 836    | 14   | 33   | 1068 | 133  | 1071 |
|    | https://github.com/sleuthkit/sleuthkit.git              |        |        |      |      |      |      |      |
|    | f64f3836b13786e8a0cc4454e765517f1d1799c4                |        |        |      |      |      |      |      |

| 29 | mig                                                     | 623    | 29     | 2    | 3    | 21   | 6    | 7    |
|    | https://github.com/mozilla/mig.git                      |        |        |      |      |      |      |      |
|    | 045db2cad71b09b1ea694e3aafb1f2f80b780ae4                |        |        |      |      |      |      |      |

| 30 | MozDef                                                  | 635    | 100    | 3    | 6    | 95   | 18   | 59   |
|    | https://github.com/jeffbryner/MozDef.git                |        |        |      |      |      |      |      |
|    | 08805587a9d4e64a30808ea5c16254e273003881                |        |        |      |      |      |      |      |

| 31 | hoosegow                                                | 197    | 36     | 0    | 2    | 19   | 1    | 19   |
|    | https://github.com/github/hoosegow.git                  |        |        |      |      |      |      |      |
|    | 5a4994c3748cbd242ba796e8d88004e042d3e18a                |        |        |      |      |      |      |      |

| 32 | backbone                                                | 2719   | 732    | 34   | 55   | 544  | 177  | 303  |
|    | https://github.com/jashkenas/backbone.git               |        |        |      |      |      |      |      |
|    | 84db2ba31ce92bba95df90eb3bead5cd4cbcc579                |        |        |      |      |      |      |      |

| 33 | ember.js                                                | 7943   | 2621   | 65   | 103  | 1363 | 461  | 924  |
|    | https://github.com/emberjs/ember.js.git                 |        |        |      |      |      |      |      |
|    | 984093e35de29c2e4f409543885257e91da71ef1                |        |        |      |      |      |      |      |

| 34 | knockout                                                | 1292   | 251    | 9    | 4    | 166  | 34   | 112  |
|    | https://github.com/knockout/knockout.git                |        |        |      |      |      |      |      |
|    | 624ddacd5a879ef5bf555d89e648f982a6bd6a4e                |        |        |      |      |      |      |      |

| 35 | todomvc                                                 | 2013   | 464    | 10   | 15   | 368  | 55   | 331  |
|    | https://github.com/tastejs/todomvc.git                  |        |        |      |      |      |      |      |
|    | 83d21c671af8ca5fff1d42b5f5ae600539386cd8                |        |        |      |      |      |      |      |

| 36 | spine                                                   | 830    | 163    | 8    | 10   | 92   | 30   | 36   |
|    | https://github.com/spine/spine.git                      |        |        |      |      |      |      |      |
|    | b7fd062637d8fbf4abc28b8dad693dfb13c85f52                |        |        |      |      |      |      |      |

| 37 | polymer                                                 | 1673   | 144    | 7    | 7    | 255  | 36   | 118  |
|    | https://github.com/Polymer/polymer.git                  |        |        |      |      |      |      |      |
|    | 2d000d10fec1b2415fa4edabfed2b8641264deee                |        |        |      |      |      |      |      |

| 38 | brick                                                   | 683    | 93     | 1    | 2    | 55   | 14   | 35   |
|    | https://github.com/mozbrick/brick.git                   |        |        |      |      |      |      |      |
|    | 4cf4100085e736805f5f57b6f09da0e724cd4099                |        |        |      |      |      |      |      |

| 39 | rubocop                                                 | 2940   | 693    | 11   | 27   | 188  | 79   | 100  |
|    | https://github.com/bbatsov/rubocop.git                  |        |        |      |      |      |      |      |
|    | 7a6dc7f786c94581b2e9adbfd7ca54ccde46b279                |        |        |      |      |      |      |      |

| 40 | hlint                                                   | 1832   | 30     | 0    | 13   | 21   | 13   | 10   |
|    | https://github.com/ndmitchell/hlint.git                 |        |        |      |      |      |      |      |
|    | d5981719bdf4cce52a711d70157ad4f8b3e8e066                |        |        |      |      |      |      |      |

| 41 | coffeelint                                              | 676    | 101    | 4    | 7    | 57   | 21   | 29   |
|    | https://github.com/clutchski/coffeelint.git             |        |        |      |      |      |      |      |
|    | ea87b4c714cb64c3a04312c24bf5e8e424f45afd                |        |        |      |      |      |      |      |

| 42 | csslint                                                 | 502    | 103    | 3    | 6    | 62   | 19   | 36   |
|    | https://github.com/CSSLint/csslint.git                  |        |        |      |      |      |      |      |
|    | c59f2e50aa8e50fae487365321d326f5830436dd                |        |        |      |      |      |      |      |

| 43 | scss-lint                                               | 582    | 1      | 1    | 0    | 0    | 5    | 32   |
|    | https://github.com/causes/scss-lint.git                 |        |        |      |      |      |      |      |
|    | cff05b9e2213decd336574ad88a87736d859f5ca                |        |        |      |      |      |      |      |

| 44 | shellcheck                                              | 505    | 30     | 3    | 3    | 20   | 11   | 6    |
|    | https://github.com/koalaman/shellcheck.git              |        |        |      |      |      |      |      |
|    | 8bed447411106fe77817ee6de33b06b5356bd98f                |        |        |      |      |      |      |      |

| 45 | puppet-lint                                             | 708    | 101    | 0    | 2    | 45   | 18   | 22   |
|    | https://github.com/rodjek/puppet-lint.git               |        |        |      |      |      |      |      |
|    | 5a8c4524115485a1f922fa4b9f14257d9be6b7cc                |        |        |      |      |      |      |      |

| 46 | eslint                                                  | 1671   | 631    | 3    | 33   | 336  | 78   | 231  |
|    | https://github.com/eslint/eslint.git                    |        |        |      |      |      |      |      |
|    | d397bbd893ed08b447409ea14ff9319261a7400b                |        |        |      |      |      |      |      |

| 47 | oclint                                                  | 727    | 98     | 1    | 2    | 98   | 6    | 86   |
|    | https://github.com/oclint/oclint.git                    |        |        |      |      |      |      |      |
|    | 2d866b4f417479901ce90a17eeaa80417c970f71                |        |        |      |      |      |      |      |

| 48 | toaruos                                                 | 1854   | 30     | 3    | 3    | 144  | 15   | 160  |
|    | https://github.com/klange/toaruos.git                   |        |        |      |      |      |      |      |
|    | 9f34619078f92bd7d9815c541a3a01ff9a86d9d1                |        |        |      |      |      |      |      |

| 49 | phaser                                                  | 696    | 113    | 0    | 4    | 86   | 45   | 48   |
|    | https://github.com/photonstorm/phaser.git               |        |        |      |      |      |      |      |
|    | 53caac2008962ac1ac3b8d46c6e38b776985acd7                |        |        |      |      |      |      |      |

| 50 | melonJS                                                 | 2802   | 224    | 32   | 30   | 297  | 107  | 391  |
|    | https://github.com/melonjs/melonJS.git                  |        |        |      |      |      |      |      |
|    | db5fd2aad206d3ffd402cb4e43216852eaf901ca                |        |        |      |      |      |      |      |

| 51 | Crafty                                                  | 1528   | 462    | 6    | 17   | 265  | 65   | 152  |
|    | https://github.com/craftyjs/Crafty.git                  |        |        |      |      |      |      |      |
|    | 5508cb1bf94b5ed82688d50ce2aacbfb99b5ff72                |        |        |      |      |      |      |      |

| 52 | cocos2d-html5                                           | 6213   | 2873   | 6    | 100  | 1443 | 275  | 1151 |
|    | https://github.com/cocos2d/cocos2d-html5.git            |        |        |      |      |      |      |      |
|    | 167a29bec38f4b461a57476034875fe4fd3e21eb                |        |        |      |      |      |      |      |

| 53 | engine                                                  | 3206   | 1026   | 4    | 23   | 487  | 53   | 133  |
|    | https://github.com/playcanvas/engine.git                |        |        |      |      |      |      |      |
|    | adc69eea0a929361cd13463d9d788b8e2d4d8e6f                |        |        |      |      |      |      |      |

| 54 | panda.js                                                | 693    | 36     | 0    | 5    | 31   | 15   | 21   |
|    | https://github.com/ekelokorpi/panda.js.git              |        |        |      |      |      |      |      |
|    | f77a876e1fe396b822412eba276a4fce0a3c6476                |        |        |      |      |      |      |      |

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

