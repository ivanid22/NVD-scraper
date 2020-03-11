require 'nokogiri'
require 'open-uri'

class CVEEntry
  def initialize(title, link, description, discovery_date)
    @title = title
    @link = link
    @description = description
    @discovery_date = discovery_date
  end
end
