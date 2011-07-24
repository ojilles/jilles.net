---
layout: default
title: Colophon
---

Colophon
--------
This is my weblog and my little corner on the internet. [See here for more
information about me]({{site.baseurl}}/about.html). I've build many big sites
in my professional career, so I figured a small weblog should be possible. To
be honest this is probably already incarnation number 4 ([see old
version]({{site.baseurl}}/perma/2006/03/05/welcome-to-v3-blog/index.html)) of
the site. Hope you enjoy.

### General Setup
The first few years I ran my personally crafted blogging system, which was
great because I could experiment with it as a software developer. After my
spare time became too scarce I moved it all over to a Wordpress blog.
Maintaining that became too hard though: keeping up with all the security
patches alone is too much work.

So the current iteration of the site you are looking at is completely
statically generated. Here is the software I use:

* The Engine
    * For the engine I use [Jekyll](https://github.com/mojombo/jekyll) 
    * I have since modified Jekyll quite a bit, particularily the build system, based on [Rake](http://martinfowler.com/articles/rake.html)
    * Javascript, using [jQuery](http://jquery.com/) in combination with [Google Closure](http://code.google.com/closure/) to compile my own javascripts
    * Thanks to the completely backwards native ftp client on Mac OS X, I'm using
      NcFTP to deploy to production
* The production environment
    * Hosted by one.com
    * [Disqus](http://disqus.com/) for the commenting system, where enabled
* The development environment
    * Git and [Github](https://github.com/ojilles/jilles.net/) to maintain all the data
    * [Backing up Github](http://paltman.com/2008/11/02/backup-script-for-github/)
    * I use [VIM](http://www.vim.org) to author all the articles and any coding needed
* Design inspiration
    * Color scheme from [kuler](http://kuler.adobe.com/#themeID/1344020)
    * Background image from [Subtlepatterns.com](http://subtlepatterns.com/)
    * CSS: [960gs Grid system](http://960.gs/)

### Credits and Acknoledgments
Like most people that get started with Jekyll, I looked at the Github
repositories out there and build off of one that comes closest to what I 
want. I did the same thing and want to acknoledge the work [Bryan Matthew
Warren](http://coffeecomrade.com/) has done. You will find 
[his work on Github](https://github.com/haircut/coffeecomrade.com).

[Herjen Oldenbeuving](http://www.herjen.nl) did an initial review and gave me
some valueable feedback.

### Copyright and -lefts
My writing, photographs, graphics, and any other original content is covered by
a [Creative Commons Attribution-NonCommercial-NoDerivs 3.0 Unported License](http://creativecommons.org/licenses/by-nc-nd/3.0/).
In simple terms, you can reuse whatever you like from this site for
non-commercial purposes, so long as you give me an attributive credit in the
form of a link back to this site and do not modify the work. I would also
appreciate it if you let me know how and where you're using my work.

Anything else is strictly copyrighted by me, unless it is copyrighted by a
third party:

* Google Analytics tags
* Disqus integration
* Similar things like the above

So if you decide to make a derrivative work based on my stuff, do not reuse
these.
