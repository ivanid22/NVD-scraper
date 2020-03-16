require_relative '../lib/cve_detailed_entry'

RSpec.describe CVEDetailedEntry do
  let(:valid_link_cve_entry) do
    CVEDetailedEntry.new(
      'CVE-2020-9517',
      'https://web.nvd.nist.gov/view/vuln/detail?vulnId=CVE-2020-9517',
      'test description',
      '2020-03-09T16:15:16Z'
    )
  end

  let(:invalid_link_cve_entry) do
    CVEDetailedEntry.new(
      'CVE-2020-9517',
      'nolink',
      'test description',
      '2020-03-09T16:15:16Z'
    )
  end

  describe '#scrape_additional_data' do
    it 'should fetch details on a valid CVE entry and populate instance values' do
      valid_link_cve_entry.scrape_additional_data
      expect(
        valid_link_cve_entry.score_cvss3.is_a?(String) &&
        valid_link_cve_entry.score_cvss2.is_a?(String) &&
        !valid_link_cve_entry.vulnerability_references.empty?
      ).to eql(true)
    end

    it 'should fail to fetch details on an invalid CVE entry and instance values should remain empty' do
      invalid_link_cve_entry.scrape_additional_data
      expect(
        invalid_link_cve_entry.score_cvss3.nil? &&
        invalid_link_cve_entry.score_cvss2.nil? &&
        invalid_link_cve_entry.vulnerability_references.empty?
      ).to eql(true)
    end
  end
end
