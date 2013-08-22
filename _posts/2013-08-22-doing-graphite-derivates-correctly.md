---
published: true
layout: post
title: How to do Graphite Derivatives correctly
permalink: perma/2013/08/22/how-to-do-graphite-derivatives-correctly
categories:
- Technology
---

Something that I see going wrong quite often with the use of Graphite is the
order in which derivatives work in graphite. ([Function reference for nonNegativeDerivative](http://graphite.readthedocs.org/en/0.9.12/functions.html#graphite.render.functions.nonNegativeDerivative))

> TL;DR: If you use `nonNegativeDerivative()` or `derivative()` put it as close
> as possible around the data source and you will be fine.

For example, if we have the following "raw" data in graphite:

![Raw data][pic1]

Basically, a bunch of counters across various different machines. Most likely,
you will want to see this derived and consequently summed or averaged out
(depending on what you are looking at of course). Quite often I then see
graphs like this:

![Problem chart with spikes][pic2]

The problem you see here is that due to any number of reasons the data got
disturbed and you see these spikes (in my example twice) which completely
obscures the real data (get's pushed to the x-axis).

Possible causes are:

* Servers were not able to push data to graphite

* Internal counters got looped b/c integer space

* Internal counters got reset b/c service restart (or similar)

What causes these spikes? Due to the fact that we first sum the different data
sources, the data looks like this right before reaching the
`nonNegativeDerivative()` function:

![Summed data][pic3]

And indeed a proper derivation of this data would give you these spikes. The
solution to this is to put the `nonNegativeDerivative` closest to the data
source. (NB: You would not necessarily see these spikes if you are only
looking at one data source, but then... why are you using Graphite?)

From: `nonNegativeDerivative(sumSeries(cs-*.aggregation-cpu-average.cpu-user.value))`

To: `sumSeries(nonNegativeDerivative(cs-*.aggregation-cpu-average.cpu-user.value))`

The resulting graphs will be much more informative (without obscuring the fact
that the data collections were interrupted) and the derivations will work
properly.

![Proper chart][pic4]

[pic1]: {{site.baseurl}}/photos/graphite/pic1-raw-data.png
[pic2]: {{site.baseurl}}/photos/graphite/pic2-nnderivative.png
[pic3]: {{site.baseurl}}/photos/graphite/pic2-raw-data-summed.png
[pic4]: {{site.baseurl}}/photos/graphite/pic3-correct.png
