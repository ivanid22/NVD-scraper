#!/usr/bin/env ruby
require 'nokogiri'
require 'open-uri'
require 'colorize'
require_relative '../lib/cve_entry'
require_relative '../lib/cve_detailed_entry'
require_relative '../lib/reporting'
require_relative '../lib/argument_validation'

NVD_FEED_URL = 'https://nvd.nist.gov/feeds/xml/cve/misc/nvd-rss.xml'.freeze
cve_entries = []

if ARGV.length >= 1
  print "\nRetrieving feed data...\n"
  cve_entries = CVEEntry.retrieve_entries(NVD_FEED_URL) if ArgumentValidation.valid_arguments_format?(ARGV)

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
