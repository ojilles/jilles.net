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
I'm assuming you have a Hadoop cluster with Oozie running already. In my case I have data coming into `/user/me/application/datacenter/year/month/day/machine.log`. The scenario described here assumes we are setting up a Coordinator for a specific application that runs in two data centers across multiple machines. Every night the JSON-formatted source data are uploaded. Let's imagine that we want to search through those logs on a particular keyword, then order any matching records by time and store the results.

What we want to achieve here is that this happens automagically, for past and future data.