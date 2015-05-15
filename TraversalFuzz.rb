#!/usr/bin/env ruby
require 'wwmd'
require 'example_mixins'
include WWMD
puts "Traversal Fuzzer made by Outlasted\n Greetz to .:TeaMp0isoN:."
opts = { :base_url => "http://www.example.com" }
page = Page.new(opts)
spider = page.spider ;
spider.set_ignore([ /logout/i, /login/i ]) ;
while (url = spider.next) ;
 code,size = page.get(url) ;
 page.summary ;
end
fuzz = File.read("traversal_list.txt").split("\n")
while (url = spider.next)
 code,size = page.get(url)
 next unless (form = page.get_form) ;
 oform = form.clone ;
 form.each do |k,v| ;
 fuzz.each do |f| ;
 form[k] = f ;
 r = Regexp.new(Regexp.escape(f),"i") ;
 page.submit(form) ;
 form = oform.clone ;#
 next unless page.body_data.match(r) ;
 puts "Path Traversal in #{k} | #{form.action}" ;# 
 end
 end
 page.submit(oform) ;
them
end