#! /bin/bash

# Here's what I did to run the site under MacOS straight up (as VirtualBox ran into permission hell)
#brew update
#brew install ruby
#add the following line to .bash_profile: 'export PATH=/Users/joldenbeuving/.gem/ruby/2.6.0/bin:/usr/local/opt/ruby/bin:$PATH'
#gem install --user-install bundler jekyll
#echo "set modeline" > ~/.vimrc
#sudo apachectl start
#add virtual host info from below into httpd.conf, main document root thing. Scortched earth style.
#brew install sass/sass/sass   #because the original SAS was depricated
#gem install rake
#rm Gemfile.lock
#bundle install
#remove last line Gemfile.lock (bundled with 2.0.2 or whatever), then run `jekyll` see if it works
# enable rewrite rules in httpd2.conf on the mac, by uncommenting the following line, then restart httpd
# LoadModule rewrite_module libexec/apache2/mod_rewrite.so
# finish here in 2019


sudo apt-get -y update
sudo apt-get -y install build-essential zlib1g-dev libssl-dev libreadline6-dev libyaml-dev git apache2 tidy
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

mkdir -p /home/vagrant/.ssh
chmod 700 /home/vagrant/.ssh
cat <<EOFSSH > /home/vagrant/.ssh/config
Host prod
        Hostname ssh.jilles.net
        User jilles.net

Host *
ServerAliveInterval 30
ServerAliveCountMax 120
EOFSSH

# setting time stuff correct
sudo VBoxService --timesync-set-threshold 1000


# setting motd
cat << EOFMOTD > /tmp/motd
   __  _ _ _                        _                  _     _             
   \ \(_) | | ___  ___   _ __   ___| |_  __      _____| |__ | | ___   ____ 
    \ \ | | |/ _ \/ __| | '_ \ / _ \ __| \ \ /\ / / _ \ '_ \| |/ _ \ / _  |
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
# ensure ssh connectivity for pub/priv key 
git remote set-url origin git@github.com:ojilles/jilles.net.git
rake dev

# if host system has private key for production environment, 
# copy it in for easy deployment
if [ -f /vagrant/id_rsa ];
then
   cp /vagrant/id_rsa /home/vagrant/.ssh/
   chmod 0700 /home/vagrant/.ssh/id_rsa
else
   echo "No private key found for production environment. In your host system run: 'cp ~/.ssh/id_rsa .'"
fi

echo 'Open up your browser to: http://localhost:4000'





exit
# new attempt on ubuntu (20200523)
sudo apt install ruby-full build-essential zlib1g-dev tidy sass apache2

gem install bundler jekyll
bundle install
bundle lock --update
bundler
#and run:
rake dev

# images
#  https://pixabay.com/
#  https://unsplash.com/
