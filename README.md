# Jilles.net
***
Here's the source for my blog. As I base I took Coffecomrade.com's weblog and went from there. For now, this has not been published at all (jilles.net is still running the old software). I'm merely using this as a base to experiment from.

Recuirements
------------
Thanks to the braindead native FTP client on Mac OS X, you'll need to install NcFTP (See: http://www.ncftp.com/ncftp/doc/ncftpput.html) :

    sudo port install NcFTP

In addition ruby-gsl. Installation instructions here: http://blog.patrickcrosby.com/2010/03/06/ruby-jekyll-lsi-classifier-fixes.html. Actually, with the newer versions something got fixes somewhere, and the manual code changes are not necessary anymore.

    sudo port install gsl
    mkdir ~/tmp
    cd ~/tmp
    svn checkout svn://rubyforge.org/var/svn/rb-gsl/trunk
    cd trunk/rb-gsl/
    ruby setup.rb config
    ruby setup.rb setup
    sudo ruby setup.rb install
    sudo gem install classifier
    
