require 'nokogiri'
require 'open-uri'
require 'colorize'
require './lib/cve_entry'
require './lib/cve_detailed_entry'
require './lib/reporting'

doc = Nokogiri::XML(open('https://nvd.nist.gov/feeds/xml/cve/misc/nvd-rss.xml'))

doc.remove_namespaces!
entries = []

doc.search('item').each do |item|
  entries.push(CVEEntry.new(item.children[1].child.content, item.children[3].child.content, item.children[5].child.content, item.children[7].child.content) )
end

Reporting.show_all_entries(entries)
