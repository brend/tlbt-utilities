#!/usr/bin/ruby
###     created: 2017-11-26 by waldrumpus
### description: Tingle's Love Balloon Trip tag stripper
###              strips control code tags from the Tingle script.
###              Examples: <0>, <2><1>, <bleh> will be stripped
###              (anything between angle brackets really)
###       usage: provide script as stdin; receive stripped script on stdout
###   licensing: see file "UNLICENSE"

e = /\<.*?\>/

ARGF.each do |c|

  puts c.to_s.gsub(e, '')
end
