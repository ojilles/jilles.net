#! /bin/bash
sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev ncftp git apache2 tidy
cd /tmp
wget http://cache.ruby-lang.org/pub/ruby/2.0/ruby-2.0.0-p353.tar.gz
tar -xvzf ruby-2.0.0-p353.tar.gz
cd ruby-2.0.0-p353/
./configure --prefix=/usr/local
make
sudo make install
sudo gem install jekyll
sudo gem install therubyracer
sudo gem install rouge
sudo gem install sass

# Make modelines work for VIM
echo "set modeline" > ~/.vimrc

HERE DOC for Apache Virtual Host configuration
sudo cat << EOFAPACHE > /etc/apache2/sites-available/jilles
<VirtualHost *:4000>
  ServerAdmin ojilles@gmail.com
  DocumentRoot /vagrant/jilles.net/_site
  <Directory "/vagrant/jilles.net/_site">
    Options Indexes FollowSymLinks MultiViews 
    AllowOverride All
    Order allow,deny
    Allow from all
  </Directory>    
</VirtualHost>
EOFAPACHE
# and make it available to serve as well
sudo ln -s /etc/apache2/sites-available/jilles /etc/apache2/sites-enabled/010-jilles

# Ensure Apache is listening on port 4k as well
sudo cat << EOFPORT >> /etc/apache2/ports.conf
# here for jilles.net blog
NameVirtualHost *:4000
Listen 4000
EOFPORT

sudo apachectl restart
