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
