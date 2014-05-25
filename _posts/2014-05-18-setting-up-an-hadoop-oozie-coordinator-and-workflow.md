---
layout: post
title: Setting up a Hadoop Oozie Coordinator and Workflow
published: false
comments: true
image:
  feature: elephants.jpg
  credits: https://www.flickr.com/photos/blieusong/7234335792/
  uicolor: light
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

The input for this process is a JSON accesslog from a relatively large application, and paraphrased, looks like this (two randomized entries):

{% highlight json %}
{"requestIp":"22.249.73.204","url":"http://www.example.com/zlkasdfj/url.extension.html",
"date":1366788978906,"userAgent":"Mozilla/5.0","requestTimeMillis":209,
"dispatchTime":209,"ssl":false,"responseCode":200,"responseSize":22443,"method":"GET",
"sessionId":"1f66d92b-66dd-727675d1bab7","loggedInUserId":"",
"uniqueRequestId":"9df01305-ae4b-6dee17b2069b"}

{"requestIp":"22.209.91.3","url":"http://www.example.com/moreurls.galore.html",
"date":1366788979022,"userAgent":"Mozilla/4.0","requestTimeMillis":96,"dispatchTime":96,
"ssl":false,"responseCode":200,"responseSize":17180,"referrer":
"http://www.example.com/previous.page.galore.html","method":"GET",
"sessionId":"b1e11781-3c2b-82b2-c761478e262a","loggedInUserId":"",
"uniqueRequestId":"12c7445a-5e-fa8-81d4-19222a421ba6","gaCookie__utmb":"161234094.18.14.1366"}
{% endhighlight %}

Once the Pig script has gone through it (and provided it found matches), the output looks like this:

     1366788979022,{"url":"http://www.example.com", "ip":"127.0.0.1", etc }

I'm using the following pig script for this:









## Reference material
The following articles/links helped me stiching the above together, they may provide you with additional leads as well:

- This [old documentation page](https://github.com/yahoo/oozie/wiki/Oozie-Coord-Use-Cases) from Yahoo (creators of Oozie) was unproportionally informative due to its practical content.
- [Using Oozie to process daily logs](http://ehukai.com/2011/06/14/using-oozie-to-process-daily-logs/) is roughly an equivalent blog post to this.
- [Using Oozie in a Kerberized Hadoop cluster](http://prodlife.wordpress.com/2013/11/22/using-oozie-in-kerberized-cluster/)





















