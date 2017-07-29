def solve numbers, target
  if numbers.size < 2 then return false end
  mem = {}
  numbers.each_with_index do |number, i|
    if mem.has_key? number
      return [mem[number], i]
    else
      mem[target - number] = i
    end
  end
  return false
end

{
  [[2, 7, 11, 15], 9] => [0, 1]
}.each do |input, output|
  result = solve input[0], input[1]
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
