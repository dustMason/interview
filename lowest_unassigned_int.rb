def lowest_unassigned_int numbers=[]
  # edge case: if there are no numbers, return 1
  return 1 if numbers.empty?
  
  sorted = numbers.sort
  
  # edge case: sorted starts with 1 and size == sorted.last.
  # - all numbers are allocated, just give last+1
  if sorted[0] == 1 && sorted.size == sorted.last
    return sorted.last + 1
  end
  
  # start with i = 1, keep incrementing until i != sorted[i-1]
  # then return i
  i = 1
  sorted.each do |n|
    return i if i != n
    i += 1
  end
end

{
  [5, 3, 1] => 2,
  [5, 9, 100] => 1,
  (1..1000000).to_a => 1000001,
  [1, 2, 3, 4, 5] => 6,
  [2, 3, 4, 5] => 1,
  [7, 1, 5, 2, 3] => 4,
  [] => 1
}.each do |input, output|
  result = lowest_unassigned_int input
  if result == output
    puts "pass"
  else
    puts "--"
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
    puts "--"
  end
end
