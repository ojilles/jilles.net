---
layout: post
title: Search engine basics
permalink: perma/2007/12/24/search-engine-basics
post_id: 61
categories: 
- Technology
---

Over at Marktplaats.nl we have developed one of The Netherlands' biggest search
engines (we're doing so many searches per day, and making it easy for buyers to
find the things they are looking for is considered "core business"). A <a
href="http://www.tbray.org/ongoing/When/200x/2003/07/30/OnSearchTOC">post by
Tim Bray</a> actually summarizes nicely the basics of a search engine. 

The post is already 4 years old (posted in late 2003) but is still quite
relevant. It focuses primarily on __filtering__ to a relevant result set,
although it doesn't ignore __sorting__ there is so much more one can do in that
area nowadays.

For those that are absolutely new to this area, or find them selves playing with this type of technology but want to read up on it I especially recommend the following articles:

* <a href="http://www.tbray.org/ongoing/When/200x/2003/06/15/OnSearch">Backgrounder</a>
* <a href="http://www.tbray.org/ongoing/When/200x/2003/06/17/SearchUsers">The Users</a>
* <a href="http://www.tbray.org/ongoing/When/200x/2003/06/18/HowSearchWorks">Basic Basics</a>
* <a href="http://www.tbray.org/ongoing/When/200x/2003/07/11/Stopwords">Stop words</a>
* <a href="http://www.tbray.org/ongoing/When/200x/2003/06/24/IntelligentSearch">Result Ranking</a> (__sorting__)

And, before you think about breaking the market and build an intelligent search
engine, please <a
href="http://www.tbray.org/ongoing/When/200x/2003/06/24/IntelligentSearch">read
this</a>. 

Excellent write up, even 4 years later. Thanks Tim!

<a
href="http://glinden.blogspot.com/2007/12/papers-from-wsdm-2008-on-click-position.html">Another
post</a>, more related to <strike>relevance and the order your results will
appear</strike> the relevance you can attach to users click behavior. In
short, users are generally inclined to click on items at the top more
frequently, so basing your relevance metrics on this you need to "un bias"
your data. 

Secondly, as users get further down the result set -in the aggregate- they are
going to switch to a different mode of selecting the items they are going to
click on: they will actually start reading the excerpts and decide, based on
the information present on the result set, on which items to click. In other
words, here you should actually **not** try to "un bias" your data!
 

