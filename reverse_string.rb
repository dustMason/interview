def reverse input
  return input unless input.size > 0
  str = input.dup
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
  result = reverse input
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
