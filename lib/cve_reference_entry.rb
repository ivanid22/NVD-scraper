class CVEReferenceEntry
  attr_reader :tags, :link

  def initialize(link, tags = [])
    @link = link
    @tags = tags
  end

  def add_tag(tag)
    @tags.push(tag)
  end
end
