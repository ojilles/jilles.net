---
layout: post
title: Database? No database?
permalink: perma/2006/04/28/database-and-mysql
post_id: 27
categories: 
- Technology
---

There are a lot of interesting discussions and posts going on lately on how
certain high profile websites. Particulary, a series of posts on O'Reilly
Radar. The <a
href="http://radar.oreilly.com/archives/2006/04/web_20_and_databases_part_1_se.html">first
post is about Second Life</a>, where they talk about MySQL (seperate
master-slave pairs handling the data partitions with one master-slave pair
indicating where what data lives).

The <a
href="http://radar.oreilly.com/archives/2006/04/database_war_stories_2_bloglin.html">second
installment features Bloglines</a> which uses MySQL (Users and passwords in one
master-slave, feed information in another) but also large parts in some file
storage.

A <a
href="http://radar.oreilly.com/archives/2006/04/database_war_stories_3_flickr.html">third
posting talks about Flickr</a>, who basically started out with the "one
database fits all"-methodology on MySQL. And this is where I think experience
really comes into play. If you were designing the Flickr database with, for
example, Bloglines' experience under your belt you would not have started out
that way. But Flicker too, couldn't escape the segmentation and divided their
data up in what they call "shards" (seperate master-slave pairs as I read it).

So, it is pretty apperent that MySQL is being used for some fairly large sites
while most of these employ the strategy of segmenting the data across several
master-slave combinations. <a
href="http://radar.oreilly.com/archives/2006/04/database_war_stories_2_bloglin.html">Some</a>
are actually useing LiveJournals'  <a
href="http://www.danga.com/memcached/">memcached </a>too!
