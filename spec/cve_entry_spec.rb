require './lib/cve_entry'

RSpec.describe CVEEntry do
  describe '#retrieve_entries' do
    it 'should retrieve an array of all CVE entries from the NVD feed at the provided valid url' do
      expect(
        CVEEntry.retrieve_entries('https://nvd.nist.gov/feeds/xml/cve/misc/nvd-rss.xml').length
      ).not_to eql(0)
    end

    it 'should return an empty array if url is invalid or no entries are present on the feed' do
      expect(
        CVEEntry.retrieve_entries('invalid_url').length
      ).to eql(0)
    end
  end
end
