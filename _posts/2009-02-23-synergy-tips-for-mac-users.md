---
layout: post
title: Synergy tips for Mac users
permalink: perma/2009/02/23/synergy-tips-for-mac-users
post_id: 182
categories: 
- Technology
---

Just installed the <a href="http://synergy2.sourceforge.net/">Synergy</a>
application. (<a href="http://synergy2.sourceforge.net/about.html">Quick into
here</a>.) If you have more than one computer you can use this to keep using
one keyboard/mouse pair for all your computers on the network. You just move
your cursor off the screen and onto the next computer without lifting your
hands! Really neat. Also, clipboards are shared so that you can copy text from
one computer and paste it onto the other one.

My primary computer is a Mac Book Air, and as such it has "hot corners": the
upper right corner for example shows my desktop. With synergy they are a bit
hard to reach since you quickly move to the other PC. If you want to make it
easy on yourself, just do the following in your configuration file:

        air:
                right(10,90) = pc

Which defines the pc as being to the right of my laptop, but only starting from
10% of the screen until 90% of the screen, neatly disabling Synergy in the
corners.
