require_relative '../lib/argument_validation'
require_relative '../lib/cve_entry'
require_relative '../lib/cve_detailed_entry'

RSpec.describe ArgumentValidation do
  let(:cve_entries) do
    [CVEEntry.new('CVE-2020-1234', 'link', 'desc', 'date'),
     CVEEntry.new('CVE-2020-5678', 'link', 'desc', 'date'),
     CVEEntry.new('CVE-2020-0102', 'link', 'desc', 'date')]
  end

  describe '#valid_arguments_format?' do
    it 'should return true if arguments are well formatted' do
      expect(
        ArgumentValidation.valid_arguments_format?(['list']) &&
        ArgumentValidation.valid_arguments_format?(%w[details CVE-2020-1234])
      ).to eql(true)
    end

    it 'should return false if arguments are formatted incorrectly' do
      expect(
        ArgumentValidation.valid_arguments_format?([]) ||
        ArgumentValidation.valid_arguments_format?(['lsit']) ||
        ArgumentValidation.valid_arguments_format?(['describe']) ||
        ArgumentValidation.valid_arguments_format?(['details'])
      ).to eql(false)
    end
  end

  describe '#valid_cve_string?' do
    it 'should return an integer (position for first match) for a valid CVE id string' do
      expect(
        ArgumentValidation.valid_cve_string?('CVE-2020-1234') &&
        ArgumentValidation.valid_cve_string?('CVE-2019-5678') &&
        ArgumentValidation.valid_cve_string?('CVE-2018-0012')
      ).to eql(0)
    end

    it 'should return nil for an invalid CVE id string' do
      expect(
        ArgumentValidation.valid_cve_string?('') ||
        ArgumentValidation.valid_cve_string?('CVE20201234') ||
        ArgumentValidation.valid_cve_string?('cve-2020-1234') ||
        ArgumentValidation.valid_cve_string?('CVE_2020_1234')
      ).to eql(nil)
    end
  end

  describe '#find_cve_match' do
    it 'should return an instance of CVEDetailedEntry when it matches with the provided id' do
      expect(
        ArgumentValidation.find_cve_match('CVE-2020-1234', cve_entries)
      ).to be_a(CVEDetailedEntry)
    end

    it 'should return nil when no entries match the provided id' do
      expect(
        ArgumentValidation.find_cve_match('CVE-2019-1234', cve_entries)
      ).to eql(nil)
    end
  end
end
