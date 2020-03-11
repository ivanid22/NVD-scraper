require 'nokogiri'
require 'open-uri'
require './lib/cve_entry'
require './lib/cve_reference_entry'

class CVEDetailedEntry < CVEEntry
  # rubocop:disable Layout/LineLength
  CVSS2_SCORE_ELEMENT_ID = '#p_lt_WebPartZone1_zoneCenter_pageplaceholder_p_lt_WebPartZone1_zoneCenter_VulnerabilityDetail_VulnFormView_Cvss2CalculatorAnchor'.freeze
  CVSS3_SCORE_ATTRIBUTE = "//a[@data-testid='vuln-cvss3-panel-score']".freeze
  VULN_LINKS_TABLE_ATTRIBUTE = "//table[@data-testid='vuln-hyperlinks-table']/tbody/tr".freeze
  # rubocop:enable Layout/LineLength

  def initialize(title, link, description, discovery_date)
    super(title, link, description, discovery_date)
    @vulnerability_references = []
  end

  def scrape_additional_data
    req = Nokogiri::HTML(URI.open('https://nvd.nist.gov/vuln/detail/CVE-2020-9458'))
    req.remove_namespaces!
    @score_cvss3 = req.search(CVSS3_SCORE_ATTRIBUTE).children[0].content || nil
    @score_cvss2 = req.css(CVSS2_SCORE_ELEMENT_ID).children[0].content || nil
    vuln_data = req.search(VULN_LINKS_TABLE_ATTRIBUTE)
    vuln_data.each do |vuln_row|
        entry = CVEReferenceEntry.new(vuln_row.children[1].child.child.to_s)
        vuln_row.children[3].children.each do |tag|
          entry.add_tag(tag.child.to_s) if tag.child.to_s.length.positive?
        end
        @vulnerability_references.push(entry)
    end
  end

end
