require 'rake/clean'

$remote = "jilles.net@ftp.jilles.net:jilles.net/test"

$local_url = "file:///Users/ojilles/jilles.net/_site"
$production_url = "http://www.jilles.net/jilles_net"

desc 'Development: Rebuild the site'
task :dev => [:dev_config, :build]

desc 'Production: build only, don\'t upload'
task :prod => [:prod_config, :build]
#task :prod_build => [:publish_only, :ping_sitemap, :pingomatic, :push]

desc 'Production: push to github, build and upload'
task :prod_send => [:push, :prod_config, :build, :send]


CLOBBER.include('_flickr.cache', 'images/tn')
CLEAN.include('_site/')

desc 'Configure for development'
task :dev_config do
  puts "* Configuring _config.yml for development... "
  edit_config('baseurl', $local_url) 
end

desc 'Configure for production'
task :prod_config do
  puts "* Configuring _config.yml for production... "
  edit_config('baseurl', $production_url) 
end

desc 'Run Jekyll to generate the site'
task :build do
  puts '* Generating static site with Jekyll'
  sh "jekyll"
end

desc 'Upload the _site content'
task :send do
  # Should test if _site/ exists
  sh "ncftpput -f ~/.ncftp/bookmarks -m -S tmp -R jilles_net _site/*"
end

task :check_git do
  status = `git status --porcelain --untracked-files=no`
  if status =~ /\S/
    puts " ! Warning: working directory is not clean. Please commit!!"
    puts " ! and don't forget to run 'rake push' after the commit."
    fail
  end
end

desc 'Git push to all remotes'
task :push => :check_git do
  remotes = `git remote`.split
  puts "* Pushing code to all remote repositories (#{remotes.join(", ")})"
  remotes.each do |remote|
    sh "git push #{remote} --all"
  end
end


## Helpers

def edit_config(option_name, value)
  config = File.read("_config.yml")
  regexp = Regexp.new('(^\s*' + option_name + '\s*:\s*)(\S+)(\s*)$')
  config.sub!(regexp,'\1'+value+'\3')
  File.open("_config.yml", 'w') {|f| f.write(config)}
end

