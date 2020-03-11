
module ArgumentValidation
  def self.valid_cve_string?(str)
    /CVE-(\d+)-(\d+)/ === str
  end

  def self.valid_arguments_format?(args)
    return false if args.length < 1
    if args.length == 1
      return true if args[0].upcase == 'LIST'
      false
    elsif args.length >= 2
      return true if args[0].upcase == 'DETAILS'
      false
    else
      false
    end
  end

  def self.find_cve_match(cve_id, entries)
    match = nil
    entries.each do |e|
      match = CVEDetailedEntry.new(e.title, e.link, e.description, e.discovery_date) if cve_id == e.title.split(' ')[0]
    end
    match
  end

end