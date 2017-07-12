def max_duffel_bag_value cakes, capacity
  return 0 if cakes.empty?
  
  weight = 0
  value = 0
  index = 0
  
  ranked = cakes.sort do |a, b|
    (b[1] / b[0]) - (a[1] / a[0]) rescue 0
  end
  
  return 0 if ranked[index].empty?
  infinite = false
  
  until index >= ranked.size do
    
    # its weightless, and worth something
    if ranked[index][0] == 0 && ranked[index][1] > 0
      infinite = true
      index = ranked.size
      break
    end
    
    # its worthless
    if ranked[index][1] == 0
      index += 1
      next
    end
    
    # we can't fit it
    if weight + ranked[index][0] > capacity
      index += 1
      
    # cake pls
    else
      value += ranked[index][1]
      weight += ranked[index][0]
    end
    
  end
  
  return Float::INFINITY if infinite
  
  value
end

{
  [[[7, 160], [3, 90], [2, 15]], 20] => 555,
  [[[7, 160], [3, 90], [2, 15]], 0] => 0,
  [[[]], 100] => 0,
  [[[0, 1]], 100] => Float::INFINITY,
  [[[0, 0]], 100] => 0,
}.each do |input, output|
  result = max_duffel_bag_value input[0], input[1]
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
