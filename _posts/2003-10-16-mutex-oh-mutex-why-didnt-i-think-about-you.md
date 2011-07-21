---
layout: post
title: "Mutex, oh mutex, why didn't I think about you?"
permalink: perma/2003/10/16/mutex-oh-mutex-why-didnt-i-think-about-you
post_id: 17
categories: 
- Software Development
---

Today something reminded me of something I picked up from Jeffrey Richter, who talked about Mutexes in his book ([Programming Windows Applications](http://www.booksamillion.com/ncom/books?isbn=1572319968&AID=42121&PID=237566)). I just failed to apply the principle to something that lives in a different context. The mutexes which I learned about were Windows API programming. The problem I faced was in shell scripting under Linux.

One thing with updating a live environment (read: a production server) is that you need to be in control of that environment to install a new version. We actually have this part pretty well covered, so that is positive. But as always, there are things to improve upon.

For our application we use a series of cronjobs that do all the maintenance-like tasks belonging to our application. In order to update the live environment we disable all the cronjobs. However, there is still this chance that one of those cronjobs already started and is still busy doing its job, while we try to update the environment. Not good. So that is why I wrote some shell scripts (we are on Linux) that parses the crontab file and uses a listing of programs that are currently running in the system ("ps" anyone?) and compares the two. If one of the cronjobs is found running on the system, we wait for it to finish and repeat the procedure, until all cronjobs have finished. This worked pretty well, and since I don't write Bash scripts and Awk scripts everyday I picked up some new skills.

But then a colleague of mine told about how he fixed the same problem in a different project. That was when it finally hit me: instead of going through the trouble of parsing some text file, parsing output of other programs, comparing and waiting; all pretty error prone I should have thought about mutexes!

A mutex gets its name from MUTually EXclusive (other one or the other-type of thing). In windows there are API's to create these things and you can use them between multiple threads or processes. One of those threads gets the handle to a mutex and the others are able to wait upon that mutex to be returned to the operating system, who on it's turn decides which one of the waiting threads get the handle to that mutex next. This is used go protect a resource (like accessing a shared variable or the like).

My situation with the cronjobs was pretty similar: either the cronjobs got control of the production system or our installation script. Seems pretty mutually exclusive to me, in after sight at least.

So what to do about this? Linux doesn't support mutexes (at least I haven't heard of these things) in a shell (sure they are implemented in C/Java/etc.). So we have to settle for something that simulates it's behavior, something that was the defacto practice 10, maybe 15 years ago: usage of the file system to communicate between threads and/or processes (so called _semaphores_).

Every cronjob will create a file in a specific directory. This should be the very first this the cronjob does. The last thing it does is removing this particular file. Then, when our install script is going to run it just needs to keep monitoring this directory, until all files are gone! If you'd like true mutex behavior, you'd have to let the install script write a file of it's own and prohibit all the cronjobs from running while this file is present. This, however, is not needed in our situation because we first turn off the cronjobs all together.

One last thing that this solution doesn't provide is something the windows API variant did provide: atomicity! But, I leave that as an exercise to the reader (if they are not thoroughly bored by now)!
