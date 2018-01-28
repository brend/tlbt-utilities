#!/usr/bin/ruby
###     created: 2017-11-26 by waldrumpus
### description: Tingle's Love Balloon Trip issue detector
###       usage: provide script as stdin; receive lines with issues on stdout
###              Lines in the output have their line number and a short issue
###              description (LINECOUNT, LINELENGTH, ...) with them.
###              Note that the issues are only guesses; it doesn't mean that
###              lines in the output are definitely incorrect.
###   licensing: see file "UNLICENSE"

script_line_index = 0

def dubious(line)
  line.gsub(/<.*?>/, '').length > 27 && 
    !(line =~ /[Dd][Ee][Bb][Uu][Gg]/) &&
    !(line =~ /デバッグ/)
end

ARGF.each do |script_line|
  pages = script_line.split /<2><1>|<2>/
  
  if script_line.include? "<0>"
    pages.each do |page|
      lines = page.split /<0>/
      
      puts "#{script_line_index}: LINECOUNT: #{page}" if pages.count > 1 && lines.count > 2
      
      lines.each do |line|
        puts "#{script_line_index}: LINELENGTH: #{line}" if dubious line
      end
    end
  end
  
  script_line_index += 1
end
