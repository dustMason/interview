def non_divisible_subset k, arr
  remainders = arr.map { |n| n % k }
  
  pairs = (1..k/2).map { |n| [n, k-n] }
  counts = Hash.new { 0 }
  total = 0
  
  remainders.each do |rem|
    counts[rem] += 1
  end
  
  pairs.each do |pair|
    if pair[0] == pair[1] && counts[pair[0]] > 0
      total += 1
    else
      total += [counts[pair[0]], counts[pair[1]]].max
    end
  end
  
  if counts[0] > 0
    total += 1
  end
  
  total
end


{
  [3, [1, 7, 2, 4]] => 3,
  [2, [2, 4, 6, 8]] => 0,
  [4, [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]] => 5,
}.each do |inputs, output|
  result = non_divisible_subset inputs[0], inputs[1]
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{inputs} expected #{output} got #{result}"
  end
end
