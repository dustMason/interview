def best_subarray nums, k
  drop = nums.size - k
  out = [9]
  nums.each do |n|
    while drop > 0 && out.last < n
      out.pop
      drop -= 1
    end
    out << n
  end
  out[1..k]
end

def max_number nums1, nums2, k
  ([k-nums2.size, 0].max..[nums1.size, k].min).map do |k1|
    parts = [best_subarray(nums1, k1), best_subarray(nums2, k-k1)]
    (1..k).map { parts.max.shift }
  end.max
end

{
  [[3, 4, 6, 5], [9, 1, 2, 5, 8, 3], 5] => [9, 8, 6, 5, 3],
  [[6, 7], [6, 0, 4], 5] => [6, 7, 6, 0, 4],
  [[3, 9], [8, 9], 3] => [9, 8, 9],
  [[8, 9], [3, 9], 3] => [9, 8, 9],
}.each do |inputs, output|
  result = max_number inputs[0], inputs[1], inputs[2]
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{inputs} expected #{output} got #{result}"
  end
end
