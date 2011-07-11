---
layout: post
title: On Subversion
permalink: /perma/2003/07/12/on-subersion/
post_id: 11
categories: 
- Software Development
---

I've been playing around with SCM systems (Software Configuration Management)
earlier (played around with
[CVS](http://web.archive.org/web/20041031181619/http:/www.cvshome.org/), VSS
and
[BitKeeper](http://web.archive.org/web/20041031181619/http:/www.bitkeeper.com/).
Of these three CVS has in my opinion the best thing going for it (large, very
large, adoption easily extendable, etc.). At that time (a few years back now)
I already noticed
[Subersion](http://web.archive.org/web/20041031181619/http:/subversion.tigris.org/),
abbreviated to SVN. At that moment they had all the plans ready (architecture,
etc.) and I think they were in their 0.1's (version). Now I'm running a
decently sized project on CVS I'm keeping my eyes open for alternatives, and
SVN is one of the best candidates (BitKeeper looses it because of the
licenses).

One of the best features of SVN (in my opinion) is the branching strategy
they've taken. Although I already had experience with CVS, other team-members
didn't have that when we switched to CVS. Explaining all the stuff and the
command line options is simple enough. But the one thing I've noticed that is
the hardest to pick up for new users is branching. Of course, you'll draw some
pretty tree-like pictures and start explaining the stuff; everyone says he/she
gets it. But when it is put to practice I see enough things going wrong
regarding branches.

One of the biggest obstacles, imho, is the fact that branches are on another dimension in CVS. People forget to switch between branches and trunk because it's not obvious on which one they are working. This is not the case in SVN, here a branch is just a full copy of the trunk, originating from a certain revision. You can do stuff like this with SVN:

	\Project1
		\trunk
			\src
			\doc
		\branches
			\feature1
				\src
				\doc
			\jilles-playing-ground
				\src
				\doc

This is a huge improvement over CVS and it will be so much easier to explain this to people new to SCM/CVS/SVN. Perfect. Another improvement is very obvious: every change to the repository results in a new revision of the **entire** repository. This way directories and such can also be versioned.

Why am I still using CVS? Well, I'm still missing some features from SVN, but those will come in time. There is a nice cvs2svn script that I _will_ check out sometime. But paraphrasing Joel Spolsky: a good tactic to convert people to your product is to make it easy to switch back. That's why I'd like to see a svn2cvs script. Having such a script enables people to easy switch back to CVS once they decide that they like that better (unlikely) or they decide that SVN doesn't have the features they want yet (more likely that the previous reason).

One other disadvantage of SVN: the tags. Under CVS a branch and a tag are two different beasts. Under SVN (as far as I see it/read it in the docs) they are both the same. Besides the directories "trunk" and "branches" you can create a directory "tags" and essentially create branches. So far so good, thanks to SVN's shallow copying technique this is fast and doesn't consume much disk space. My take on a tag is: "_constant snapshot of the tree at a certain moment_". Note the word **constant**. Once I declare version 1.4 of my product and build, package and ship it I **do not** want the option/feature of changing the 1.4 tag in the repository and thereby creating a difference between the 1.4 version in the tree and the 1.4 version that is installed at the customer. 

Of course, an administrator should be able to move that tag around in case of an erroneous tag command but this should not be made easy. But in subversion a tag is tag only because of the way the developer looks at it. I'd like a command in SVN that would enable me to "freeze" a branch: such that once I create a tag (read: branch) I can freeze it and thereby disallowing all developers from committing to that branch, ensuring that version X in the tree is the same version X that I'll ship.

(Of course, I know that if you create a "tag" and some developer commits changes to it, you can easily back out of those changes, but that would just be mending your wounds instead of preventing the wound ever from taking place.)

All in all though, I like SVN (much better than CVS). I'm just biding my time till they reach a version more close to their 1.0 release