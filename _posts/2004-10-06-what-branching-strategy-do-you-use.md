---
layout: post
title: What branching strategy do you use?
permalink: perma/2004/10/06/what-branching-strategy-do-you-use
post_id: 18
categories: 
- Software Development
---

Yesterday I found myself writing a branching strategy. We've been using a
software configuration tool (CVS) since I've been working there. But the
branching strategy was somewhat ad-hoc. Whatever we felt like, we did. Now our
new project nears its first release onto production servers, I thought it was
time to re-think our branching strategy. When thinking about how to branch, it
seems to me it is choosing between overhead and stability. The more branches
you use, the more work is independent from each other, providing stability to
that branch. However, the more branches you create, the more work goes into
merging those branches, documenting what's on which branch, etc.

Having such a branch strategy helps at least in one way: everyone should learn
this strategy by hart. Once that is done, nobody will be surprised as in: "Oh?
I didn't know we created a new branch for that functionality".But coming up
with good versioning tactics that "don't get in the way" too much is pretty
hard. Of course, there has been some scientific research done in that field.
That resulted into some pretty documents that cover everything from A to Z. (I
particularly like that document that treats all of the branching tactics like
another GoF pattern.) Of course, there is a lot of difference between the
strategies involved for an internal product, a shrink-wrapped product or a
website.

Obviously, [Marktplaats.nl](http://www.marktplaats.nl/) is in the website
department here. But even then, there are a lot of differences. It has already
been in some newspapers that we are opening websites in foreign countries
(foreign to The Netherlands that is). Aha, that opens up entirely another can
of worms. Now we deploy our website for multiple countries. Each of these
countries could run a different version of our product. That might been driven
by the fact that in some countries (country A) a particular feature is hard
needed, but in others maybe not (country B). But then, where do you do the bug
fixing? Both country A and B need that same bug fix, but what has been deployed
for those countries might reside on different branches! That brings in a lot
more overhead if you ask me.


Even armed with a lot of scientific articles about this topic I'm still in
doubt about what strategy to choose. So I'd like to invite everyone who's in
the same situation as me to contact me. What branching strategy do _you_ use?
What do you like about it? What policies do you have in place? And most of all,
I'd like to get in touch with [Joel Spolsky](http://www.joelonsoftware.com)
about this topic. He's advocating the usage of a SCM-tool (just like me!), but
every tool has is incorrect usages. Joel, how are you using CVS to maintain
your [product](http://www.gooflr.com)?
