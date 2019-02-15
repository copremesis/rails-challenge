# frozen_string_literal: true

class Util
  def self.scrape_tags(member)
    agent = Mechanize.new
    page =  agent.get member.original_url
    %w[h1 h2 h3].each do |header|
      page.xpath('//' + header).map do |h|
        tag_info = { tag_type: header, text: h.text.strip }
        member.tags.create tag_info
      end
    end
  rescue StandardError => e
    puts e
  end
end
