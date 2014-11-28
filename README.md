# Jilles.net
***
Here's the source for my blog. At first this was based on Coffecomrade.com's weblog 
but since 2014 I have switched to Balzac (see footer of the site for links)


Features
--------

* Obviously completely based off of Jekyll (v2)
* Rake build system around it so compile other assets (SASS, etc) in a consistent manner
* Rake integrated with git such that nothing EVER will be pushed to PROD without that being both in git and pushed to github.com
* Integrated link checking (will spider the whole site on DEV and PROD builds so that you can not push internal links that result in 404's)
* Tidy integration so that all pages' source code look good and well formatted
* Entire VM around it so that you can reproduce this setup anywhere, anytime (quite handy for an infrequent blogger such as me)

Copyright and -lefts
--------------------
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

Requirements
------------

For installation purporses (development, etc) I recommend to run

```
  $ git clone https://github.com/ojilles/jilles.net.git
  $ cd jilles.net
  $ vagrant up       # will kickoff provision, will take some time
  $ vagrant ssh
  $ cd /vagrant
```

Open your browser (on the host machine) to http://localhost:4000

This assumes you're running a ubuntu 12.04 image, newer most likely works as well. The image that
is used and tested was downloaded here: 

  http://puppet-vagrant-boxes.puppetlabs.com/ubuntu-server-12042-x64-vbox4210-nocm.box
