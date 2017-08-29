def invert_number num
  num.digits(2).reverse.reduce(0) { |acc, n| (acc << 1) + (n + 1) % 2 }
end

{
  0b1 => 0b0,
  0b10101 => 0b1010,
  0b11111 => 0b0,
  0b10001 => 0b1110,
  0b1000 => 0b111,
  0b11001100 => 0b00110011,
  0b11010000 => 0b00101111,
}.each do |input, output|
  result = invert_number input
  if result == output
    puts "pass"
  else
    puts "fail given #{input.to_s(2)} expected #{output.to_s(2)}, got #{result.to_s(2)}"
  end
end
