class Util
  def self.scrape_tags(member)
    agent = Mechanize.new
    page =  agent.get member.short_url
    %w(h1 h2 h3).each {|header|
      page.xpath('//' + header).map {|h|
        tag_info =  { tag_type: header,  text: h.text.strip}
        member.tags.create tag_info
      }
    }
  rescue => e
    puts e
  end
end
