# Strip whitespace from a string in-place
# don't use String#delete, String#gsub

def strip_whitespace str
  spaces = 0
  str.each_char.each_with_index do |char, i|
    if char == " " # stand-in for a 'real' whitespace check
      str.slice! i-spaces
      spaces += 1
    end
  end
  str
end

{
  "he llo" => "hello",
  "r a c e c a r" => "racecar",
  "   " => "",
  "long     gap" => "longgap",
}.each do |input, output|
  result = strip_whitespace input.dup
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
