---
layout: post
title: Specifications? How?
permalink: perma/2004/07/10/software-specifications-but-how/
post_id: 6
categories: 
- Software Development
---

[This post is a re-post of a question I asked at [Joelonsoftware.com's discussion forums](http://discuss.fogcreek.com/joelonsoftware/default.asp?cmd=show&ixPost=161422&ixReplies=0)]

Before I start of this post, I'd like to refer to certain other sources to
prove that Specifications are important for any software development. It works
the same as house construction: no company is going to build a house without a
blueprint (heck, they won't even get permission to build it otherwise!).

First off, lets link to the Joel test, specifically [the part about writing
specs](http://purpleslurple.net/ps.php?theurl=http://www.joelonsoftware.com/articles/fog0000000043.html#purp119).
Any questions about why you would write specifications [read this
article](http://www.joelonsoftware.com/articles/fog0000000036.html). More
information can be found <a
href="http://en.wikipedia.org/wiki/Requirements_gathering">here on
Wikipedia</a>.

**The question I have is: how would you go about to document the
specifications?** [This
PDF](http://www.stc-online.org/cd-rom/1999/slides/MethWrit.pdf) talks about
possible options on pages 109 and 115, but how would you do this?

Everything always boils down to what you really want to do with it. Well,
actually, not very much. Specification is firstly a means to communicate the
exact soon-to-be implementation to those who should sign-off the project.
Secondly, it should be the basis for a technical design document and later the
actual implementation. Furthermore, it should provide the definitive answer for
testing: should this box be red or blue? As a last needed feature is to be able
to quickly see the differences between specific versions of the specification
(What was changed since version x.y.z?).

So what would be a good way to document these specifications? Because I want
ways to quickly show differences between versions I thought about CVS and
docbook (together with a tool, Norman Walsh (diffmk), to generate a proper HTML
document containing differences between two versions of the docbook's XML
document). But this proves a little bit tiresome, especially when large volumes
of pictures and diagrams are involved. A positive side of the usage of CVS is
that multiple people can work on the specifications. Thats why, in my opinion,
dismisses solutions like Word and/or Excel. It is good to know that [other
people](http://purpleslurple.net/ps.php?theurl=http://www.mojofat.com/tutorial/step6.html#purp106)
are struggling with [the same
problems](http://discuss.fogcreek.com/joelonsoftware/default.asp?cmd=show&ixPost=81284&ixReplies=21).

Basically the core of this post is to ask: What ways of specification would you
use in similar circumstances? Got any answers to this? Do you want to discuss
about this topic with me? Write me an email, post a comment on Joel on Software
or post a comment at this post.
