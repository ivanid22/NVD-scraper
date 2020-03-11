#!/usr/bin/env ruby
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

if ARGV.length >= 1
  print "\nRetrieving feed data...\n"
  cve_entries = retrieve_entries(NVD_FEED_URL) if ArgumentValidation.valid_arguments_format?(ARGV)

  case ARGV[0].upcase
  when 'LIST'
    Reporting.show_all_entries(cve_entries)
  when 'DETAILS'
    ARGV.drop(1).each do |id|
      details = ArgumentValidation.find_cve_match(id, cve_entries)
      if details
        print "\nretrieving data for #{id}...\n\n"
        details.scrape_additional_data
        Reporting.show_detailed_entry(details)
      else
        puts "no match for #{id} found\n"
      end
      print "\n------------------------------------\n"
    end
  else
    Reporting.print_usage
  end
else
  Reporting.print_usage
end



