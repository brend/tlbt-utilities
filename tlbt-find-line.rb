#! /usr/bin/ruby

###     created: 2015-08-19 by waldrumpus
### description: Tingle's Love Balloon Trip line finder
###              finds text in game script and returns location info
###       usage: tlbt-find-line.rb <game script file name> <search regexp>
###              Use tlbt-cobble-text.rb to create the game script file.
###   licensing: see file "UNLICENSE"

if ARGV.length < 2
  puts "usage: tlbt-find-line.rb <script file name> <search regexp>"
  exit(1)
end

game_script_file = ARGV[0]
seach_regexp = Regexp.compile(ARGV[1])

unless File.exists?(game_script_file)
  puts "file #{game_script_file} does not exist"
  exit(1)
end
            
script = File.open(game_script_file).read

last_page_lines = [1000, 
                   1999, 
                   3030, 
                   4231,
                   5344,
                   6693,
                   7999,
                   9897,
                   10998,
                   12142,
                   13043]

script.lines.each_with_index do |line, line_index|
  next unless seach_regexp.match line
  
  page_number = last_page_lines.find_index {|ll| line_index < ll}
  
  if page_number
    puts "#{line_index}  #{page_number + 1}: #{line}"
  else
    puts "error: invalid page number for line #{line_index}"
  end
end

                   