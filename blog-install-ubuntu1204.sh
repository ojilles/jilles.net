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
echo "set modeline" > ~/.vimrc
