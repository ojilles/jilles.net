# Jilles.net
***
Here's the source for my blog. As I base I took Coffecomrade.com's weblog and
went from there. For now, this has not been published at all (jilles.net is
still running the old software). I'm merely using this as a base to experiment
from.

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
Thanks to the braindead native FTP client on Mac OS X, you'll need to install
NcFTP (See: http://www.ncftp.com/ncftp/doc/ncftpput.html) :

    sudo port install NcFTP

Then also create ~/.ncftp/bookmarks with the following content:
    host ftp.jilles.net
    user USERNAME
    pass PASSWORD

In addition ruby-gsl. Installation instructions here:
http://blog.patrickcrosby.com/2010/03/06/ruby-jekyll-lsi-classifier-fixes.html.
Actually, with the newer versions something got fixes somewhere, and the manual
code changes are not necessary anymore.

    sudo port install gsl
    mkdir ~/tmp
    cd ~/tmp
    svn checkout svn://rubyforge.org/var/svn/rb-gsl/trunk
    cd trunk/rb-gsl/
    ruby setup.rb config
    ruby setup.rb setup
    sudo ruby setup.rb install
    sudo gem install classifier

For development purposes, one could add something similar to the apache config (remove default site):

	<VirtualHost *:80>
		DocumentRoot /vagrant/jilles.net/_site
			# Alias for jilles.net
			Alias /jilles.net "/vagrant/jilles.net/_site"
			<Directory "/vagrant/jilles.net/_site">
						 Options Indexes FollowSymLinks MultiViews 
						 AllowOverride All
						 Order allow,deny
						 Allow from all
			</Directory>    
	</VirtualHost>


In addition, I have a few drafted posts. If you want to build those, you'll need an as of yet unreleased feature of Jekyll.

1 - Check if my changes have been merged in (in which case an up to date version of Jekyll should do it)
    https://github.com/mojombo/jekyll/pull/374
2 - Otherwise download and install this gem: http://www.jilles.net/gems/jekyll-0.11.1.gem


Todo's
------
Mainly a list of blogposts I still need to adapt, that I skipped the first pass
(usually images involved).

* Check if iframe is ok at 2006-09-20-quick-post-on-my-ski-plans-this-season.md
* Check if iframe is ok at 2006-09-23-recent-purchases.md
* same for 2008-02-24-skiing.md
* double check presentation embed at 2008-04-28-pfcongrez_marktplaats_architecture.md

Decided to move over my wp-content dir verbatim, so the following ones should
be okay after that:

* Fix image at 2008-10-27-on-user-experience.md
* fix image at 2008-11-15-panolab-iphone-application.md
* Fix image at 2008-11-16-my-social-network-is-changing.md
* 2006-05-19-google-tests-new-feature.md
* 2006-05-28-moola-weekend-millionaires-for-the-rest-of-us.md
* Copy over the map of westendorf and link properly at:
  2006-08-27-map-of-westendorf.md

