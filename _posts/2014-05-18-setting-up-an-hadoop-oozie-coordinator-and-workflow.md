---
layout: post
title: Setting up an Hadoop Oozie Coordinator and Workflow
published: false
image_titles: false
categories: 
  - Technology
---

After many frustrating hours of tweaking I have finally setup a working
[Oozie](https://oozie.apache.org/)
[Coordinator](https://oozie.apache.org/docs/3.1.3-incubating/CoordinatorFunctionalSpec.html)
plus associated
[Workflow](https://oozie.apache.org/docs/3.1.3-incubating/WorkflowFunctionalSpec.html)
on [Hadoop](http://hadoop.apache.org) (in my case [Cloudera](http://www.cloudera.com/content/cloudera/en/about/hadoop-and-big-data.html)'s distribution). This was quite frustrating
because of many small problems that are completely non-intuative and not
documented. So I thought I should write this down so that others can benefit
(and for myself to have a canonical write up).

## The Starting Conditions
I'm assuming you have a Hadoop cluster with Oozie running already. In my case I have data coming into `/user/me/application/datacenter/year/month/day/machine.log`. The scenario described here assumes we are setting up a Coordinator for a specific application that runs in two data centers across multiple machines. Every night the JSON-formatted source data are uploaded. Let's imagine that we want to search through those logs on a particular keyword (or in our example, IP address), then order any matching records by time and store the results.

What we want to achieve here is that this happens automagically, for past and future data with some level of fault tolerance.

We will build up the solution from lowest level up:

`Pig Action -> Workflow -> Coordinator ( -> Bundle )`

One can couple a few associated coordinators together as one deployment unit called a Bundle. This can come in handy to build out a bigger "Data Pipeline" (see here, for example, a [write up of Tapad and Stripe's data pipelines](http://www.hakkalabs.co/articles/big-small-hot-or-cold-your-data-needs-a-robust-pipeline-examples-from-stripe-tapad-etsy-square)). From an Oozie perspective, actually all of these are optional, letting you start off as small as you would like.

All source material can be found in the following TODO Github repository.

## Pig Action
The imagined use case is that I would like to have all the incoming data scanned for a particular Regex such as a set of source IP addresses. If found reconstitute a timeline for that IP address then safe off the timestamps.

The input for this process is a JSON accesslog from a relatively large application, and paraphrased, looks like this:

    TODO: Add input data

Once the Pig script has gone through it (and provided it found matches), the output looks like this:

    <unix time stamp> { "url":"http://www.example.com", "ip":"127.0.0.1", etc }

I'm using the following pig script for this:
