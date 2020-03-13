require 'nokogiri'
require 'open-uri'

class CVEEntry
  attr_reader :title, :link, :description, :discovery_date

  def initialize(title, link, description, discovery_date)
    @title = title
    @link = link
    @description = description
    @discovery_date = discovery_date
  end

  def self.retrieve_entries(url)
    entries = []
    begin
      doc = Nokogiri::XML(URI.open(url))
      doc.remove_namespaces!
      doc.search('item').each do |item|
        entries.push(CVEEntry.new(item.children[1].child.content,
                                  item.children[3].child.content,
                                  item.children[5].child.content,
                                  item.children[7].child.content))
      end
    rescue StandardError => e
      puts "\nCould not retrieve CVSS data: #{url}: #{e}"
      return []
    end
    entries
  end
end
