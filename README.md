# Jilles.net
***
Here's the source for my blog. As I base I took Coffecomrade.com's weblog and
went from there. For now, this has not been published at all (jilles.net is
still running the old software). I'm merely using this as a base to experiment
from.

Recuirements
------------
Thanks to the braindead native FTP client on Mac OS X, you'll need to install
NcFTP (See: http://www.ncftp.com/ncftp/doc/ncftpput.html) :

    sudo port install NcFTP

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
    

Todo's
------
Mainly a list of blogposts I still need to adapt, that I skipped the first pass
(usually images involved).

* 2006-05-19-google-tests-new-feature.md
* 2006-05-28-moola-weekend-millionaires-for-the-rest-of-us.md
* Copy over the map of westendorf and link properly at:
  2006-08-27-map-of-westendorf.md
* Check if iframe is ok at 2006-09-20-quick-post-on-my-ski-plans-this-season.md
* Check if iframe is ok at 2006-09-23-recent-purchases.md
* same for 2008-02-24-skiing.md
* double check presentation embed at 2008-04-28-pfcongrez_marktplaats_architecture.md
* Fix image at 2008-10-27-on-user-experience.md
