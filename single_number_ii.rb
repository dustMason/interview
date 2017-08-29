# @param {Integer[]} nums
# @return {Integer}
def single_number nums
  ones = 0
  twos = 0
  
  nums.each do |n|
    ones = (ones ^ n) & ~twos
    twos = (twos ^ n) & ~ones
  end
  
  ones
end

{
  [3,3,3,1] => 1,
  [1,1,1,2,2,2,3,3,3,4,5,5,5] => 4,
  [1,1,1,2,2,2,3,3,3,4,5,5,5].shuffle => 4,
  [1,1,1,1,1,2,2,2,2,2,3,3,3,3,3,4,5,5,5,5,5].shuffle => 4
}.each do |input, output|
  result = single_number input
  if result == output
    puts "pass"
  else
    puts "fail given #{input} expected #{output} got #{result}"
  end
end
