def xor_strings a, b
  (a.to_i(16) ^ b.to_i(16)).to_s 16
end

{
  %w{1c0111001f010100061a024b53535009181c 686974207468652062756c6c277320657965} =>
  '746865206b696420646f6e277420706c6179'
}.each do |(in_a, in_b), output|
  result = xor_strings in_a, in_b
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{[in_a, in_b]}"
    puts "expected #{output}"
    puts "got #{result}"
  end
end
