---
title: Bryan Cantrill Videos
# vim: set ts=2 sw=2 tw=120 ft=markdown et si :
layout: post
disable_comments: false
image:
  feature: bryan.jpg
  credits: https://www.flickr.com/photos/ncc_badiey/4932791410/
  uicolor: light
categories:
- Technology
---

Ever since seeing the [DTrace introduction
video](https://www.youtube.com/watch?v=6chLw2aodYQ) done by [Bryan
Cantrill](http://en.wikipedia.org/wiki/Bryan_Cantrill) I loved his presentation
style. Bryan is obviously a very smart technologist and overflowing with idea's
(or at least, that is how he comes across to me).  Watching that DTrace video,
it looks like his mind wants to say all these insightfull things, his ability
to speak barely keeping up with the flow.

So over the years I kept track of his presentations, and luckily Bryan has
worked on some very inspirational software throughout the years as the CTO of
[Joyent.com](http://www.joyent.com). What astonishes me is that so few people
have seen either the work Joyent has done (SmartOS, SDC, Mantra, etc) or Bryans
presentations. Apropos of conversations I have with others in the field, I
usually end up sending them a link to one or two videos (whatever feels
relevant). This happened now so often that this post subjectively aggregates
the most important ones.

### DTrace introduction (2007)
As mentioned, this was the first presentation I ever saw done by Bryan. In here
is presents his work at Sun developing
[DTrace](http://en.wikipedia.org/wiki/DTrace). DTrace is a dynamic tracing
framework that is safe to use in a production environment. It also spans across
both Kernel and User space in your operating system (such as Solaris, SmartOS
or even Mac OS!). In the video Bryan comes across as a bit of a virtuoso and
even doing ad-hoc demo's that clearly have not been prepared but work out
fantastically.   

{% youtube TgmA48fILq8 %}

Over at Sun they implemented baracuda storage appliances and used DTrace to
provide high resolution real time metrics. This, to a hilarious effect, allows
you to measure the latency impact of shouting at a disk array in an already
noisy data center:

{% youtube tDacjrSCeq4 %}

### Scaling Organizations

As you will see in the other video's Bryan knows his technology stuff, but in
this video he demonstrates acute awareness of a more organizational
perspective. He deftly summarizes which elements are important for building a
world class organization. 

{% youtube bGkVM1B5NuI %}

### Introducing Manta

[Manta](https://www.joyent.com/object-storage)  is an object storage technology
from Joyent. Whereas technologies such as Hadoop are very large and complicated
*frameworks*, Manta adheres to the Unix philosophy (small programs that do one
thing well, then compose them together to solve the problem at hand). Manta
allows you to use the Unix/Linux toolset you know already. Thanks to SmartOS
Zones, your scripts will run on the hardware where the data is located
(bringing compute to your Big Data is much easier than vice versa). Thanks to
ZFS you can get exactly the dat you need, and once you are done it will be
restored to the point before you started. Very impressive.

{% youtube 79fvDDPaIoY %}

Second video that dives deeper in the Unix philosophy and how it relates to
SmartOS Zones/Manta:

{% youtube S0mviKhVmBI %}

### Running Linux Containers on illumos kernels (such as SmartOS)

This video includes an awesome history lesson on how we got to today (2015),
and how wasteful some of what we are seeing today really is (such as Amazon
EC2). At the core of the presentation is the fact that you can now run Linux
work loads on SmartOS, get all the benefits of secure multi tenancy, ZFS,
DTrace, Zones, etc.

{% youtube TrfD3pC0VSs %}

### Corporate Open Source Anti-Patterns

Ever contemplated open sourcing a piece of techonology from your corporation?
This is a must watch video by Bryan that shows you which mistakes you should
avoid making. That is to say, there is no known rule for making it succesfull
but quite a few that will make your efforts doomed.

{% youtube Pm8P4oCIY3g %}

### Conclusion

Thats the current list. If you have more awesome videos done by Bryan, fire
away in the comments please!

(I am still contemplating writing up key take aways for each video, but that
will require quite some more time. If you have done that for one of the video's
linked above, I will happily incorporate them into this post.)
