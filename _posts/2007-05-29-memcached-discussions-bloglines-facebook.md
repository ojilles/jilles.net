---
layout: post
title: Memcached usage across large web properties
permalink: /perma/2007/05/29/memcached-discussions-bloglines-facebook/
post_id: 57
categories: 
- Open source
- Software Development
- Website architecture
---

Lately a discussion on the memcached-mailing list has started where for example
the guys behind facebook.com and bloglines.com are participating and <a
href="http://lists.danga.com/pipermail/memcached/2007-May/004098.html">sharing</a>
some of their experiences.  I'm don't think this is rocket science, but I'd
like to quote some of the things that are being said and provide some links to
the relevant discussions.

About the general "would you want to bet your uptime on memcached as an
infrastructure component?"-question: 

    We consider memcached a critical part of our infrastructure. The benefit of
    memcached in a typical setup is to reduce the amount of database hardware you
    need to support an application; if you have enough database horsepower to run
    unimpaired with most of your memcached servers out of service, then thereÂ¹s
    probably no point using memcached at all, since it without a doubt adds extra
    complexity to your application code. 
[<a href="http://lists.danga.com/pipermail/memcached/2007-May/004105.html">link</a>]

If you shard all you data, etc. etc., is memcached still worth it?

    *Question*:
    And you would split (federate) your database into 100 chunks (the remaining 100
    would be hot spares of the first 100 and could even be used to serve reads),
    wouldn't that take care of all your database load needs and pretty much
    eliminate the need for memcache? Wouldn't 50 such boxes be enough in reality?

    *Answer*:
    Don't forget about latency.  At Hi5 we cache entire user profiles that are
    composed of data from up to a dozen databases.  Each page might need access to
    many profiles.  Getting these from cache is about the only way you can achieve
    sub 500ms response times, even with the best DBs. 
[<a href="http://lists.danga.com/pipermail/memcached/2007-May/004112.html">link</a>]

Also, there is a lot of talk about a FUSE (File system in user space)
filesystem based on top of memcached. Not only would that make caching
available for those applications you do not control (blackbox) but it would
have some really great advantages for your generic PHP app:

    Over the last two weeks i spent a lot of time discussing a memcachefs
    (fuse-based) with two fellow geeks - applications that came to mind were (a)
    the smarty cache (b) php sessions; for both cases, losing files (as a whole,
    not random parts inside) is ok and readdir is irrelevant, which allows cutting
    a lot of corners. 
[<a href="http://lists.danga.com/pipermail/memcached/2007-May/004197.html">link</a>]


