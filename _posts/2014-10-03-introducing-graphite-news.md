---
title: Introducing Graphite-News
# vim: set ts=2 sw=2 tw=120 ft=markdown et si :
layout: post
disable_comments: false
image:
  feature: graphite.jpg
  credits: http://sodere.com/profiles/blogs/apgmi-confirms-graphite-potential-in-ethiopia
  uicolor: light
categories:
- Technology
---

Introduction
------------
Once you get to a decent sized Graphite instance it starts to be harder to keep
up with what *new* data is being added with the last application or service
release that just went live. 

The current crop of Graphite dashboards
([Tessera](http://urbanairship.com/blog/2014/06/30/introducing-tessera-a-graphite-frontend),
[Grafana](http://grafana.org/),
[Graphite](http://graphite.readthedocs.org/en/latest/) itself) all focus on
presenting you with all the data, but not just the recent data. This can become
troublesome in large installations with complex applications. In order to solve
this (small) need, I wrote Graphite-News.

![Graphite-News screenshot][pic1]

Functionality
-------------
Graphite-News keeps tabs on your Graphite server to see what new data sources
become available. These get listed in reverse chronological order. If you click
on one it will show the graph for your inspection. It also tries to do the
right thing; for example it will show  a metric ending in `.count` by wrapping
it in `perSecond()`.

At the top of the image there are two buttons (see [100%
screenshot]({{site.baseurl}}/photos/graphite-news-screenshot.png)). The first
one, `Edit`, will lead you straight to the Graphite Web UI so that you can play
around with it. The second one named `Remove` can be enabled optionally
(default is off). Clicking this will remove the data source from Carbon. This
can come in handy when you see bogus data sources or initial bogus data.

It is a simple first [0.0.1-alpha
release](https://github.com/ojilles/graphite-news/releases/tag/0.0.1-alpha) to
see if there is interest in a utility like this.

Installation
------------
Graphite-News is written in Go, which should make installation reasonably easy:

    $ go get github.com/ojilles/graphite-news
    $ $GOPATH/bin/graphite-news -l $GOPATH/src/github.com/ojilles/graphite-news/creates.log

More documentation can be found [in the README on
Github](https://github.com/ojilles/graphite-news).

I am actively looking for feedback, so please leave a comment here, hit me up
at [@ojilles](https://twitter.com/ojilles), or open up an [issue over at
Github](https://github.com/ojilles/graphite-news/issues).

[pic1]: {{site.baseurl}}/photos/graphite-news-screenshot.png
