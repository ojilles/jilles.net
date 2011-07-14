---
layout: post
title: Database versioning techniques
permalink: perma/2003/10/17/database-versioning-techniques
post_id: 7
categories: 
- Software Development
---

Today I had an interesting discussion with one of my colleagues. The problem being discussed had already troubled my mind a few months back, but was driven out of my mind by other, more pressing, problems (deadlines, etc.). The problem, as the title of this article suggests, is database versioning techniques. Vie searched the internet for a solution to this problem and what I found was a lot of misconception. So to eliminate that, I start of describing the problem first. Be careful, I smell a long article coming up.

A good developer keeps all his source code in an SCM tool (like CVS, Perforce, Arch, Bitkeeper, Subversion, but not Source Safe). There are some very good reasons to do this, which Imp not going to discuss here. Most applications handle data. There are even those amongst mankind that go as far as saying software and data are the same, which is true. (If you like that kind of conceptual difference, read [Godel, Escher, Bach: An Eternal Golden Braid](http:/www.amazon.com/exec/obidos/tg/detail/-/0465026567/qid=1066342116) by Douglas Hofstadter. It seems to happen in human cell replication all the time.) A large portion of this data handling software manipulates data in a convenient way: enter the database! Your software is coupled to this database. And as your software evolves (new features!) your database does too (new and/or altered tables!). So both evolve (hold that idea please).

Now, to keep the software part under version control there are three different things at work:

a) the plain text source code
b) a build script (arguably a meta-program, see G.E.B.)
c) the output of a) and b) combined, the actual program

Now since both a) and b) are under source control, c) is always achievable. (Well, in practice you need to version you build tools, which are used by the build script, too. But if you go down this road you'd have to version your entire build machine.)

Now consider the case for that database. The following aspects are at work here:

1. a SQL scripts
2. a build script that loads 1) into a particular database.

Ah! (thinking) Nope, won't work. Because most systems have a live (or production) environment. Once data has been entered into the database, you can't recreate it, because that information is not in either 1) nor 2)! And this is exactly the problem. Most developers don't go this far, and only provide 1) and 2) with their installation. But once you have to keep your production environment data alive, you have to reconsider your solution. Here we go:

1. A SQL script
2. Incremental SQL scripts that alter a live environment from version x to y
3. A build script that will run 1) and/or 2) as needed, depending on the already existing database and its version

Already better. Now this is what you see with most applications that have encountered this problem. And this will work, if your don't have 100 production databases. Problem solved, but not for us. (By the way, above solution will introduce some nasty dependencies when you are using multiple branches to store your source code and database scripts in your SCM!). So we need a different solution.

Lets iterate some goals this solution must provide:

 * It should be highly scriptable, because were using this with a lot of databases
 * We should be able to replay the action, to be able to test the solutions' successfulness
 * It doesn't have to be reversible (this is plain out impossible to achieve)

After some thinking I came up with the following solution. I was intrigued by some discussions on this topic and one of the problems seems to be to have the ability to diff SQL dump files. That people are looking at this for their solution to this problem is pretty easy to see: SQL dump files can be stored in an SCM tool like any other plain text file. But my quick searches on Google and [Joel](http:/www.joelonsoftware.com/) didn't turn up such a tool. Apparently this is something pretty hard to develop. So then it hit me: there are tools to diff instances of SQL dumps. With instances I mean real databases. Such tools take database A and database B and output a script that contains SQL instructions to get from A to B. Some of these tools don't only look at the database schema, but also at the data itself! That was halve the puzzle, I thought.

So, I think the following is good (final) solution for this particular problem:

1. With each software version make a database dump, and store it along with the source code in the SCM tool of your liking.
2. During a build, create a (temporary) database from this file, under a different name than your production database
3. Next step during the build is to fire up the diff tool and let it generate a script
4. Run the generated script

Whether this will work depends on the quality of the diff tool, obviously. But those tools are not unheard of. So there is a good chance that they exist, hopefully scriptable too. Then, there is still one last issue to resolve. Look at the goals, there it said that it is plain out impossible to reverse versions (this is like a one way street folks!). In order to ascertain that we don't try to downgrade our database the SQL dump file (step 1) could include a timestamp. Then we can insert an extra step between steps 2 and 3, that checks to see if the production database already has a newer timestamp. If so, don't run steps 3 and 4.

Well, maybe those timestamps don't suffice alone. Maybe we need to stick in some branch or version information too, but you get the idea.

The good part of this solution is that you can automate every step of this solution. Even better we can reproduce it, which aids testing before putting your stuff up on a production environment.

Well, I am calling it a night. Tomorrow I will devote some time at tricking a good diff tool for MySQL databases and see if I can prototype this kind of thing. (If anybody has some good ideas about this problem, solution of diff tool, drop me a line!).

(BTW: I wrote this a quick rant. I still have to see if this will actually work! But be sure to follow this blog because I will report my findings.)

*Edit*: Hmm, almost within 10 minutes I detected a flaw in this setup. I'll write about it at some later time.
