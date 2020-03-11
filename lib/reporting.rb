require 'colorize'
require './lib/cve_entry'
require './lib/cve_detailed_entry'
require './lib/cve_reference_entry'

module Reporting
  def self.show_all_entries(entries)
    puts 
    entries.each { |entry| show_entry(entry) }
  end

  def self.show_entry(entry)
    puts entry.title.yellow
    puts 'Link: '.light_blue + entry.link
    puts 'Date of discovery: '.light_blue + entry.discovery_date
    puts 'Description'.light_blue
    puts entry.description
    puts
  end
end