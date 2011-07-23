---
layout: post
title: Technology is hard
permalink: perma/2007/10/06/software-development-is-hard
post_id: 59
categories: 
- Technology
---

<a href="http://www.gamearchitect.net/Articles/SoftwareIsHard.html">Kyle Wilson
wrote recently</a> a really nice piece on why software development is so hard,
which for me didn't include new insights (I'm already convinced) but did a
really nice job on quantifying the problem space. Something which I had not
seen before so clearly articulated. If you're in this line of business, it's a
must read.

The thing that makes this article so interesting is that for some reason Kyle
has access to information about five large software development projects:
Chandler (the OSS Exchange replacement), Myst Online, Fracture (a new game),
the software that controls a F-22 fighter jet and the FBI's Virtual Case File.

After describing some of the pitfalls the Chandler team fell in, he goes on
trying to outline why Lines of Code (LOC) is a useless metric for determining
the complexity of a software program. More importantly, he throws in some
statistics of the aforementioned projects that really hits this home.

Short list of conclusions:

* LOC is useless as a means to describe either the complexity of the program or
  the amount of effort that went into producing it
* Project teams need an economic framework (in the broadest sense of the word)
  in order to be successful. Otherwise there is no forcing function for
  decisions (like design choices, feature sets and release dates).
* In theory the complexity of a well-structured program should be O(n), where n
  is the number of lines of code (each line only tightly coupled with the line
  preceding and after it). A poorly structured program would be O(n2), with
  dependencies on one particular line throughout the codebase.

Favorite quote, from the **1968** NATO Software Engingeering Conference: "_We
undoubtedly produce software by backward techniques. [...] We build systems
like the Wright brothers build airplanes -- build the whole thing, push it off
the cliff, let it crash, and start over again_".

And this one: "_Most software today is very much like an Egyptian pyramid with
millions of bricks piled on top of each other, with no structural integrity,
but just done by brute force and thousands of slaves_" -- Alan Kay (the father
of Smalltalk).
