---
layout: post
title: Jilles 'uses this'
image_titles: false
categories:
- Technology
---

Inspired by the articles over at [Usesthis.com](http://www.usesthis.com) I
thought I would do my own write up in similar vain.

### Hardware

Over the last 8 years all of my hardware has moved into Apple land. When I was
still programming professionally I did so exclusively on Debian/Linux systems
and that is just what I am most comfortable with. The Mac offers that experience
with the notable exception of 'apt-get' package management. 

* Main personal desktop is a 27" iMac (2008 model I believe). This is what I use
  to browse the web with, do Skype calls with family and friends back in the
  Netherlands, dabble with software development and new technologies in my spare
  time and store all my photos and music.
* A 2009 model Mac mini which is always on and provides all the media in my
  apartment. Since I live abroad I don't watch any of the local broadcasters I
  rely on this to provide some entertainment. In addition this also brings some
  non-networked disks onto my TimeCapsule powered network.
* I gave my old (1st edition) MacBook Air to my girlfriend, but will still pick
  it up if I need to write somewhere else in my apartment, away from the iMac
  (like right now). Actively looking for an excuse to buy one of the new MacBook
  Airs. I literally think this is the best laptop produced till date.
* For years I was a heavy Blackberry user, they truly made the best email
  capable phones in existence at the time. But how far the mighty can fall? The
  second the iPhone debuted, I bought one and upgrade to every new iPhone within
  weeks after it comes out.
* iPad: the primary use case here is shared internet experiences with my
  girlfriend. For example, shopping online for that new furniture addition or
  looking up information together. Sometimes a bit of travel.
* Amazon Kindle: bought this primarily for travel. I love physical books, but I
  can't afford to bring two big books on a 2-3 day business trip for example.
  Jury is still out.
* For work: I have been working for [eBay](http://www.ebay.com) for the last 8
  years or so and always been using the standard windows machines provided. But
  6 months ago I finally switched that to a MacBook Pro. I have notably more
  issues with that transition than any other transition to Apple products
  (Microsoft Outlook on Mac is seriously unproductive for example) but I'm
  managing just fine

### Software

For work I mostly use a weird combination of "standard business software" such
as Excel, PowerPoint, Outlook and Skype together with rather geeky stuff. As an
example, a lot of times I will automate data gathering with bash scripting or
look up how our users are using our sites by writing a
[Pig](http://pig.apache.org) script and run it against our
[Hadoop](http://hadoop.apache.org) cluster(s). This turns into the fun
combination of me always having a
[iTerm2](http://www.iterm2.com/#/section/home) console open, even though I do
not program for a living anymore.

Personally I use Gmail for mail, but mostly try to stay away from the web client
(not sure why, but I guess it is due to the latency difference with simple
Mail.app client). As mentioned, I use Skype a lot for international video calls. 

My browser of choice these days is Chrome, as it is fast and syncs nicely
across all my machines which is great. For a list of places on the web [where
you can find me, look here]({{site.baseurl}}/about.html). Daily (non-business)
sites I frequent are Google Reader and
[HackerNews](http://news.ycombinator.com/). Once in a while Google+, Facebook.
Interestingly for me Twitter has become iPhone only: I check it daily but find
the UEX on the iPhone just better than their main site.

After seeing internal statistics from some of our large websites and all the
hacks that make the news every week I moved to use 1Password with large random
generated passwords uniquely for each site. I also enabled two-factor
authentication for my Google account the day it came out.

For image processing I am currently using iPhoto but experimenting here and
there with Aperture after purchasing a DSLR. Not entirely sure yet on this. I do
prune my pictures quite well for each event I have in iPhoto to keep the size of
my total library down (see backups further down).

I spend quite a bit of time iTerm2, using things like screen, git, vim, etc. I
am quite bought into the Unix mantra there. For someone who likes to keep his
programming chops a little bit up to date Github really offers me a nice place
to put my small projects and at the same time a way to contribute in small
measures to the various open source projects out there.

For media consumption I use [Plex](http://www.plexapp.com/) on the Mac mini,
which is absolutely great.  Comes with a whole bunch of plugins to stream
content like The Daily Show and I have build up a nice library of ripped DVDs.
The Mac mini is hooked up to a large (European standard) television, but it
will also stream the content to the iPad or iPhone in a pinch if needed.

For my weblog (that you are reading now) I had great fun geeking out with
[Jekyll](https://github.com/mojombo/jekyll), creating a fully automated
build system using Rake and  hooking it all up with a self created low-key
template. These are no great feats of engineering, but good fun for a geek in
any case. As an example, using wget and some scripting the build system will
fail when this blog has any internal links that 404. You will find my code on my
[Github page](https://github.com/ojilles/jilles.net/). (Also see the
[colophon]({{site.baseurl}}/colophon.html).)

### Storage

I have a tick for trying to preserve most of the things that I made or had a
hand in creating. This means that I have a digital photo collection that goes
back to when my ancient Nokia phone had a 320x200 pixel camera. In addition any
software, documentation, research papers, fun websites, assembler code for
microprocessors, etc, I have written goes into my "Lifetime Archive". Not sure
why, nostalgia is partly an answer but it definitely also has it's uses. 

I now have also started this process for my offline life. Having moved
internationally twice now, paper (and especially "accessible" paper) is just
hard. So I have started to scan most important documents and store those into my
"Dead tree archive" which is a collection of PDFs that combine the graphical scan
with OCRd text.

As for SaaS providers like Gmail, [Github](http://github.com), Google Docs, etc.
all get pulled down locally by a cronjob every day or week and disappear in my
Lifetime archive. This primarily got instigated after
[Delicious](http://del.iciou.us) threatened to close down. (I consequently moved
to [Pinboard](http://pinboard.in)).

The total of all of the above, including pictures, is roughly 100GB.

Having only scarcely recovered my CD-ROM backups from 2001 (needed to combine 6
different disks to recombine the whole archive) I now store all this on my iMac
and backup religiously:

* Local backups go onto the TimeCapsule, easily accessible from my Mac
* A subset of the data gets stored onto Dropbox, but only those files that don't
  require the highest privacy
* Then there is [Crashplan](http://www.crashplan.com/) that is my primary off site backup
* Lastly, I also backup the same data using
  [Arc](http://www.haystacksoftware.com/arq/) onto Amazon S3. I'm sure
  Crashplan does the same but at these cost levels I don't care and I insulate
  myself also from Crashplan suddenly disappearing. (Arc is just software, and
  I'm betting Amazon AWS is going to be around for another 10 years). Hats off to
  Arq for doing [a lof of testing](http://www.n8gray.org/code/backup-bouncer/).

Perhaps it is a bit overdone, but I am now reasonably certain I can get to the
binary/text files in the future. A bigger concern now becomes document
compatibility. For example, I have a load of Electronics engineering reports I
wrote in WordPerfect 5.1 that are starting to look quite garbled.

### Conclusion
I often suggest Apple should start making a subscription hardware service: I
wire a pre-determined amount dollars to their bank account. In return they send
me within one week of their product launch, whatever they are launching in a set
of predetermined categories (think: laptop, desktop, iPhone and iPad). Would
that not be awesome?


I am pretty happy with my setup this far. If you have any questions or would
love to contribute, fire away in the comments below!
