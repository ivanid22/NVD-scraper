require 'nokogiri'

class CVEEntry

  def initialize(title, link, description, discovery_date)
    @title = title
    @link = link
    @description = description
    @discovery_date = discovery_date
  end

  def establish_severity
    req = Nokogiri::HTML(open(@link))
    req.remove_namespaces!
    @score_cvss3 = req.search("//a[@data-testid='vuln-cvss3-panel-score']").children[0].content || nil
    @score_cvss2 = req.css("#p_lt_WebPartZone1_zoneCenter_pageplaceholder_p_lt_WebPartZone1_zoneCenter_VulnerabilityDetail_VulnFormView_Cvss2CalculatorAnchor").children[0].content || nil
    puts @score_cvss3
  end
end