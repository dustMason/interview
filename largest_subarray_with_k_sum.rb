class Solution
  
  
  def self.subarray a, k
    
    return [] if a.empty?
    m = {}
    sum = 0
    max_len = 0
    subarray = []
    
    a.each_with_index do |n, i|
      sum += n
      
      if !m.has_key? sum
        m[sum] = i
      end
      
      if m.has_key? sum - k
        len = i - m[sum - k]
        if len > max_len
          max_len = len
          subarray = a[m[sum - k]+1..i]
        end
      end
      
    end
    
    if max_len < 1
      return []
    else
      return subarray
    end
    
  end
  
end

puts Solution.subarray([-3,-2,3,7,9,10], 1), "="*80
puts Solution.subarray([1,2,3,4,5], 9), "="*80
puts Solution.subarray([1,1,1,1,1,1,5,6,7,8,2,-100,-30,-5,-4], -130), "="*80
