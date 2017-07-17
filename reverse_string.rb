def reverse str
  return str unless str.size > 0
  len = str.size
  (len/2).times do |i|
    char = str[len-1-i]
    str[len-1-i] = str[i]
    str[i] = char
  end
  str
end

{
  "hello" => "olleh",
  "racecar" => "racecar",
  "" => "",
  "whatever" => "revetahw",
}.each do |input, output|
  result = reverse input.dup
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
