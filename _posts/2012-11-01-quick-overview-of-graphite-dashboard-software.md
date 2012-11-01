---
layout: post
title: Quick overview of Graphite Dashboard software
published: true
image_titles: false
categories:
- Technology

---

For $employer I'm looking at some dashboard software that would run on top of
our [graphite](http://graphite.wikidot.com/start) infrastructure. I started 
to run into a quite a few that look
nice, but don't fit my bill entirely. But thought it would be handy to list
them somewhere for others' benefit or my future reference.

* [Graphiti](https://github.com/paperlesspost/graphiti): Seems like a nice
  looking app that is geared towards manual creation of graphs (as such
  replacing the default graphite UI it looks like). Ruby with storage in
  Redis.

* [Tasseo](https://github.com/obfuscurity/tasseo): Very lightweight graphing
  solution. More for like an unmanned dashboard in the office than a tool for
  use. Simple JSON configuration of metrics that need to be shown.


* [Gdash](https://github.com/ripienaar/gdash): Another Ruby application, but
  unlike Graphiti, this is not geared towards graph creation, but consumption.
  Graphs and dashboards are defined by a specific DSL but the meat of that is
  graphite functions. Seems easily automatable by other processes (such as
  Chef or Puppet) but lacks zooming/panning around timelines in arbitrary ways.

* [Dashing](http://shopify.github.com/dashing/): Not even based on Graphite,
  so not included in the list really.
  [Demo](http://dashingdemo.herokuapp.com/sample) says it all really.

* [Graphene](http://jondot.github.com/graphene/): Real time unmanned graphite
  based dashboard (unlike Dashing) thats useful to continuously showcase a
  limited set of graphs.

There are more tools [listed
here](http://graphite.readthedocs.org/en/1.0/tools.html) but they were either
uninteresting or long dead (e.g. no commits in the last 2 years).
