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
on Hadoop (in my case Cloudera's distribution). This was quite frustrating
because of many small problems that are completely non-intuative and not
documented. So I thought I should write this down so that others can benefit
(and for myself to have a canonical write up).

The Setup
=========
I'm assuming you have a Hadoop cluster with Oozie running already. In my case I have data coming into `/user/me/application/datacenter/year/month/day/machine.log`

