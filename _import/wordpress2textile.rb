#!/usr/bin/env ruby

# Input: WordPress XML export file.
# Outputs: a series of Textile files ready to be included in a Jekyll site,
# and comments.yml which contains all approved comments with metadata which
# can be used for a Disqus import.
# Changes from the original gist: http://gist.github.com/268428
# 1. Handles titles containing special characters. Those have to be YAML escaped 
# 2. Use the original permalinks in wordpress.

require 'rubygems'
require 'hpricot'
require 'clothred'
require 'time'
require 'yaml'
require 'fileutils'
require 'uri'

WORDPRESS_XML_FILE_PATH = "#{ENV['PWD']}/wordpress.xml"
OUTPUT_PATH = "#{ENV['PWD']}/export/_posts"
ORIGINAL_DOMAIN = "http://www.jilles.net"

class Post
  attr_accessor :title, :post_date, :created_at, :slug, :post_id, :content, :textile_content
  attr_accessor :hpricot_element, :permalink, :categories

  def initialize(item)
    @hpricot_element = item

    @title = item.search("title").first.inner_text
    @permalink = item.at("link2").inner_text.gsub(/^#{ORIGINAL_DOMAIN}/,'').gsub(/\/$/,"/")
#    @permalink = item.at("link2").inner_text.gsub(/^#{ORIGINAL_DOMAIN}/,'').gsub(/\/$/,"/index.html")
    @permalink = URI.unescape(@permalink)
    puts "permalink #{@permalink}"
    
    @post_date = item.search("wp:post_date").first.inner_text
    @created_at = Date.parse(post_date)

    @slug = item.search("wp:post_name").first.inner_text
    
    @categories = []
    item.search("category").each { |cat| 
      @categories << cat.inner_text
    }
    @categories.uniq!
    
    p @categories

    @post_id = item.at("wp:post_id").inner_text

    @content = item.search("content:encoded").first.inner_text
    text = ClothRed.new(content)
    @textile_content = text.to_textile
  end

  def to_jekyll
    buf = ""
    buf << "---\n"
    buf << "layout: post\n"
    buf << "title: #{title.to_yaml.gsub(/^--- /,'')}" #escape character in title
    buf << "permalink: #{permalink.to_yaml.gsub(/^--- /,'').chomp}\n"
    buf << "post_id: #{post_id}\n"
    buf << "categories: #{categories.to_yaml.gsub(/^--- /,'').chomp}\n"
    buf << "---\n\n"
    buf << textile_content
  end

  def save(root_path)
    File.open("#{root_path}/#{created_at}-#{slug}.textile", "w") { |file| file.write self.to_jekyll }
    self
  end

  def save_comments(path)
    comment_elements = @hpricot_element.search("wp:comment").reject do |c|
      c.search("wp:comment_approved").inner_text != "1"
    end

    File.open("#{path}/comments.yml", "a") do |yaml_file|
      comment_elements.collect { |el| Comment.new(self, el) }.each { |comment| comment.write_to yaml_file }
    end
  end

  class << self
    def parse(element, path)
      return nil unless element.is_a?(Hpricot::Elem)
      post = Post.new(element)
      puts "saving post: #{post.title}"
      post.save(path)
    end
  end
end

class Comment
  attr_accessor :author_name, :author_email, :author_url, :content, :post

  def initialize(post, element)
    @post_id = post.post_id
    @post_title = post.title
    @author_name = element.search("wp:comment_author").first.inner_text
    @author_email = element.search("wp:comment_author_email").first.inner_text
    @author_url = element.search("wp:comment_author_url").first.inner_text
    @content = element.search("wp:comment_content").first.inner_text || ""

    comment_date = element.search("wp:comment_date_gmt").first.inner_text
    @created_at = Time.parse("#{comment_date} GMT")
  end

  def write_to(file)
    file.write self.to_yaml + "\n" unless @content.size == 0
  end
end

# main

file = File.open(WORDPRESS_XML_FILE_PATH,"rb");
contents = file.read
# Hpricot will destroy <link> contents as it expecting a <link href="">
# so we change link to link2 and Hpricot will leave it alone. 
contents.gsub!(/link>/, "link2>") 



doc = Hpricot(contents)

FileUtils.mkdir_p OUTPUT_PATH
File.open("#{OUTPUT_PATH}/comments.yml", "w") { |f| }

(doc / "item").each do |item|
  next unless item.search("wp:status").first.inner_text == "publish"
  post = Post.parse(item, OUTPUT_PATH)
  post.save_comments(OUTPUT_PATH)
end
