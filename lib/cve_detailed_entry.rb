require 'nokogiri'
require 'open-uri'
require_relative 'cve_entry'
require_relative 'cve_reference_entry'

class CVEDetailedEntry < CVEEntry
  attr_reader :score_cvss2, :score_cvss3, :vulnerability_references, :data_found
  CVSS2_SCORE_ELEMENT_ID = '[id*=zoneCenter_VulnerabilityDetail_VulnFormView_Cvss2CalculatorAnchor]'.freeze
  CVSS3_SCORE_ATTRIBUTE = "//a[@data-testid='vuln-cvss3-panel-score']".freeze
  VULN_LINKS_TABLE_ATTRIBUTE = "//table[@data-testid='vuln-hyperlinks-table']/tbody/tr".freeze

  def initialize(title, link, description, discovery_date)
    super(title, link, description, discovery_date)
    @vulnerability_references = []
  end

  private

  def retrieve_data_from_source
    @web_data = Nokogiri::HTML(URI.open(@link))
    @data_found = true
  rescue StandardError => e
    puts "\nCould not retrieve CVSS data: #{@link}: #{e}"
  end

  def extract_additional_entries_data
    vuln_data = @web_data.search(VULN_LINKS_TABLE_ATTRIBUTE)
    vuln_data.each do |vuln_row|
      entry = CVEReferenceEntry.new(vuln_row.children[1].child.child.to_s)
      vuln_row.children[3].children.each do |tag|
        entry.add_tag(tag.child.to_s) if tag.child.to_s.length.positive?
      end
      @vulnerability_references.push(entry)
    end
  end

  public

  def scrape_additional_data
    retrieve_data_from_source
    return unless @web_data

    @web_data.remove_namespaces!
    @score_cvss3 = @web_data.search(CVSS3_SCORE_ATTRIBUTE).children[0].content || nil
    @score_cvss2 = @web_data.css(CVSS2_SCORE_ELEMENT_ID).children[0].content || nil
    extract_additional_entries_data
  end
end
