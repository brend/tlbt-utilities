#! /usr/bin/ruby

###     created: 2014-12-26 by waldrumpus
### description: Tingle's Love Balloon Trip progress estimator
###              counts "localized" lines in the input
###       usage: provide text via "ARGF", i.e. stdin or file argument
###   licensing: see file "UNLICENSE"

lines = 0
translated_lines = 0

ARGF.each_line do |s|
  lines += 1
  # This script considers a line as translated, iff it does not contain any
  # character outside ascii range, i.e. with a char chode >= 256.
  # Thus, partially translated lines will not be counted.
  translated_lines += 1 if s.chars.all? {|c| c.ord < 256}
end

puts "#{translated_lines}/#{lines} translated."
