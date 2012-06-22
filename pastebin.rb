#!env ruby
# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'
# we gonna get the raw version, located at http://pastebin.com/raw.php?i=id"
#we gonna save it at data/id.txt

ids = Marshal.load File.read('ids_pastebin.txt')

while id = ids.pop do
	next if File.exist? "data/#{id}.txt"
  	doc = Hpricot(open("http://pastebin.org/raw.php?i=#{id}"))
	next if doc.nil?
        open("data/#{id}.txt", "wb" ) do |file|
		file.write(doc.inner_html)
        end
	sleep rand(10)+1
end
