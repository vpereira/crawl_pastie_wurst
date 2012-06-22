#!env ruby
# encoding: UTF-8
require 'rubygems'
require 'open-uri'
require 'hpricot'
# we gonna get the raw version, located at http://pastie.org/pastes/id/text"
#we gonna save it at data/id.txt
4064855.upto(4113130) do |id|
  	next if File.exist? "data/#{id}.txt"
  	doc = Hpricot(open("http://pastie.org/pastes/#{id}/text"))
	content = doc.at("//body/pre")
	next if content.nil?
        open("data/#{id}.txt", "wb" ) do |file|
		file.write(content.inner_html)
        end
	sleep rand(10)
end
