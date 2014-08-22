###     created: 2014-08-22 by waldrumpus
### description: Tingle's Love Balloon Trip script cobbler
###              downloads split-up game text and merges it into single file
###       usage: no arguments required; fill in array 'page_urls' with URLs
###              of the individual pages in correct order
###   licensing: see file "UNLICENSE"

require 'net/http'

page_urls = []
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
  
  # find the line containing the javascript with the actual game text
  # heuristic: it's probably the longest line ;-)
  text_line = res.body.lines.max_by(&:length)
  
  abort("Fishy text line (max line) for URL #{url_text}") unless text_line.length > 10000
  
  # extract the game text from the surrounding javascript
  # actual text is prefixed with (including quotes)
  # "collab_client_vars":{"initialAttributedText":{"text":"
  # text is suffixed with
  # ","attribs":"
  mangled_text = text_line[/"collab_client_vars":{"initialAttributedText":{"text":".*","attribs":"/]
  
  abort("Couldn't find expected json-chunk surrounding text block in supposed text line for URL #{url_text}") if mangled_text.nil?
  
  text = mangled_text[55..-(13+1)]
  
  abort("Couldn't find text block in extracted json-chunk for URL #{url_text}") if (text || "").empty?
  
  # perform replacements to un-json and un-??? the mangled text
  text.gsub!('\n', "\n")
  text.gsub!('\x3c', '<')
  text.gsub!('\"', "\"")
  
  text.chomp! if text.end_with? "\n\n"
  
  # save result
  pages << text
end

# join pages and print'em
game_text = pages.join

print game_text
