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

#HERE DOC for Apache Virtual Host configuration
cat << EOFAPACHE > /tmp/host
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

# Ensure Apache is listening on port 4k as well
cat << EOFPORT > /tmp/port
# here for jilles.net blog
NameVirtualHost *:4000
Listen 4000
EOFPORT

sudo sh -c "cat /tmp/host >> /etc/apache2/sites-available/jilles"
sudo sh -c "cat /tmp/port >> /etc/apache2/ports.conf"
rm /tmp/port /tmp/host
sudo ln -s /etc/apache2/sites-available/jilles /etc/apache2/sites-enabled/010-jilles
sudo apachectl restart

# setting time stuff correct
sudo VBoxService --timesync-set-threshold 1000

# setting motd
cat << EOFMOTD > /tmp/motd
   __  _ _ _                        _                  _     _             
   \ \(_) | | ___  ___   _ __   ___| |_  __      _____| |__ | | ___   __ _ 
    \ \ | | |/ _ \/ __| | '_ \ / _ \ __| \ \ /\ / / _ \ '_ \| |/ _ \ / _` |
 /\_/ / | | |  __/\__ \_| | | |  __/ |_   \ V  V /  __/ |_) | | (_) | (_| |
 \___/|_|_|_|\___||___(_)_| |_|\___|\__|   \_/\_/ \___|_.__/|_|\___/ \__, |
                                                                     |___/ 
    Production:   http://www.jilles.net
    Development:  http://localhost:4000
    Repository:   https://github.com/ojilles/jilles.net

EOFMOTD
sudo mv /tmp/motd /etc/motd                                                                           

# fixing up Git
git config --global user.name "Jilles Oldenbeuving"
git config --global user.email ojilles@gmail.com
git config --global alias.lg 'log --pretty=format:"%C(yellow)%h\\ %C(green)%ad%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --date=short --graph'
git config --global alias.st "status -s --branch"
git config --global alias.ll 'log --pretty=format:"%C(yellow)%h%Cred%d\\ %Creset%s%Cblue\\ [%cn]" --decorate --numstat'
git config --global alias.gr 'grep -Ii'
git config --global alias.staged 'diff --cached'
rake dev

echo 'Open up your browser to: http://localhost:4000'
