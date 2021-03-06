require 'colorize'
require_relative 'cve_entry'
require_relative 'cve_detailed_entry'
require_relative 'cve_reference_entry'

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

  def self.show_vulnerability_reference(ref)
    print ref.link.light_blue
    ref.tags.each { |tag| print " #{tag} -".red }
    puts
  end

  def self.show_detailed_entry(entry)
    show_entry(entry)
    puts 'Threat scores:'.light_yellow
    print 'CVSS2 score: '.light_blue
    print entry.score_cvss2
    print "\nCVSS3 score: ".light_blue
    print entry.score_cvss3
    return unless entry.vulnerability_references.length.positive?

    puts "\n\nAdditional references: ".light_yellow
    entry.vulnerability_references.each { |vr| show_vulnerability_reference(vr) }
  end

  def self.print_usage
    puts 'usage: ./bin/nvd-scrape (list|details) [cve-id..]'
    puts '       ruby bin/nvd-scrape.rb (list|details) [cve-id..]'
  end
end
