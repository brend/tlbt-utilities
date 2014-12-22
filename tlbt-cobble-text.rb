#! /usr/bin/ruby

###     created: 2014-08-22 by waldrumpus
### description: Tingle's Love Balloon Trip script cobbler
###              downloads split-up game text and merges it into single file
###       usage: no arguments required; fill in array 'page_urls' with URLs
###              of the individual pages in correct order
###   licensing: see file "UNLICENSE"

require 'net/http'

page_urls = %w[]
pages = []

# must fill array 'page_urls', e.g. 
# page_urls = %w[http://.../page1 http://.../page2]
abort('Usage error: No page urls present; modify script by filling array "page_urls"') if page_urls.empty?

page_urls.each do |url_text|
  # request url contents
  url = URI.parse(url_text)
  req = Net::HTTP::Get.new(url.to_s)
  res = Net::HTTP.start(url.host, url.port) {|http|
    http.request(req)
  }
  
  text = res.body
  text.chomp! if text.end_with? "\n\n"
  
  # save result
  pages << text
end

# join pages and print'em
game_text = pages.join

print game_text
