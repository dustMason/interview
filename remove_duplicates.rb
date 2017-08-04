# @param {Integer[]} nums
# @return {Integer}
def remove_duplicates(nums)
  dupes = 0
  j = 1 # pointer to last unique val
  nums.each_with_index do |n, i|
    if i > 0 && n == nums[i-1]
      j = i - dupes
      dupes += 1
    elsif i > 0
      nums[j] = n
      j += 1
    end
  end
  len = nums.size - dupes
  nums[0..len-1]
end

{
  [1, 2, 2] => [1, 2],
  [1, 1, 2] => [1, 2],
  [1, 1, 2, 2] => [1, 2],
  [1, 1, 2, 2, 3, 4, 5, 6] => [1, 2, 3, 4, 5, 6],
  [1, 1, 1, 1] => [1],
  [0] => [0],
  [] => [],
}.each do |input, output|
  result = remove_duplicates(input.clone)
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
