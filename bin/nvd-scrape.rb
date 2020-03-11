require 'nokogiri'
require 'open-uri'
require './lib/cve_entry'
require './lib/cve_detailed_entry'

doc = Nokogiri::XML(open('https://nvd.nist.gov/feeds/xml/cve/misc/nvd-rss.xml'))

doc.remove_namespaces!
entries = []

doc.search('item').each do |item|
  entries.push(CVEDetailedEntry.new(item.children[1].child.content, item.children[3].child.content, item.children[5].child.content, item.children[7].child.content) )
  print "title: #{item.children[1].child.content}\n"
  print "link: #{item.children[3].child.content}\n"
  print "description: #{item.children[5].child.content}\n"
  print "date: #{item.children[7].child.content}\n"
  puts
end

entries.last.scrape_additional_data

