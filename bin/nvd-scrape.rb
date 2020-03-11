require 'nokogiri'
require 'open-uri'
require 'colorize'
require './lib/cve_entry'
require './lib/cve_detailed_entry'
require './lib/reporting'
require './lib/argument_validation'

NVD_FEED_URL = 'https://nvd.nist.gov/feeds/xml/cve/misc/nvd-rss.xml'.freeze
cve_entries = []

def retrieve_entries(url)
  entries = []
  doc = Nokogiri::XML(URI.open(NVD_FEED_URL))
  doc.remove_namespaces!
  doc.search('item').each do |item|
    entries.push(CVEEntry.new(item.children[1].child.content, item.children[3].child.content, item.children[5].child.content, item.children[7].child.content) )
  end
  entries
end



Reporting.show_all_entries(entries)

Reporting.print_usage if ARGV.length <= 1 || ARGV[0].upcase !== "LIST"
cve_entries = retrieve_entries(NVD_FEED_URL) if ArgumentValidation.valid_arguments.format?

case ARGV[0].upcase
  when 'LIST'    
end
