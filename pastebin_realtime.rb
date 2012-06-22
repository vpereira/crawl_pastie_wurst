#!env ruby
# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'
# we gonna get the raw version, located at http://pastebin.com/raw.php?i=id"
#we gonna save it at data/id.txt

doc = Hpricot(open('http://pastebin.com/ajax/realtime_data.php'))


doc.search('//tr/td/a').each do |link|
  #registered users have 2 links. we should fix it. for now we ignore registered users
  next if link['href'] =~ /^\/u\/.*/
  id = link['href'][1..-1] rescue nil
  next if id.nil?

  next if File.exist? "data/#{id}.txt"
  next if id =~ /\//
  sdoc = Hpricot(open("http://pastebin.com/raw.php?i=#{id}"))
  next if sdoc.nil?
  open("data/#{id}.txt", "wb" ) do |file|
	file.write(sdoc.inner_html)
  end

end

#while id = ids.pop do
#	next if File.exist? "data/#{id}.txt"
#  	doc = Hpricot(open("http://pastebin.org/raw.php?i=#{id}"))
#	next if doc.nil?
#        open("data/#{id}.txt", "wb" ) do |file|
#		file.write(doc.inner_html)
#        end
#	sleep rand(10)+1
#end
