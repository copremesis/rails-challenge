# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



require "uri"
require "net/http"

class Shorty
	def self.shorten(long_url)
		url = URI("http://shorty.dragonwrench.com/")
		http = Net::HTTP.new(url.host, url.port)
		request = Net::HTTP::Post.new(url)
		request["Content-Type"] = "application/json"
		request.body = {url: long_url}.to_json
		response = http.request(request)
		JSON.parse(response.read_body)['url']
 	end
end


#Shorty.shorten('https://en.wikipedia.org/wiki/Mark_Twain')


urls = %w(https://en.wikipedia.org/wiki/Mark_Twain
					https://en.wikipedia.org/wiki/Allan_Holdsworth
					https://en.wikipedia.org/wiki/John_McLaughlin_(musician)
          https://en.wikipedia.org/wiki/Frank_Gambale
					https://en.wikipedia.org/wiki/Paul_Gilbert
					https://en.wikipedia.org/wiki/Marty_Friedman
					https://en.wikipedia.org/wiki/Jason_Becker
					https://en.wikipedia.org/wiki/Steve_Vai)

urls.each {|url|
	agent = Mechanize.new
	page =  agent.get url
  name = url.split(/\//)[-1].humanize
	short_url = Shorty.shorten(url)
	member = Member.create({name: name, short_url: short_url, original_url: url})

	%w(h1 h2 h3).each {|header|
		page.xpath('//' + header).map {|h|
			tag_info =  { tag_type: header,  text: h.text.strip}
			member.tags.create tag_info
		}
	}
}


