# In order to win the prize for most cookies sold, my friend Alice and I are going
# to merge our Girl Scout Cookies orders and enter as one unit. Each order is
# represented by an "order id" (an integer).
# 
# We have our lists of orders sorted numerically already, in arrays. Write a
# function to merge our arrays of orders into one sorted array.

class Merger
  
  # this destroys the input arrays, which may not be desirable.
  def self.merge! left, right
    out = []
    until left.empty? && right.empty? do
      if left.first && right.first && left.first < right.first
        out << left.shift
      elsif right.first
        out << right.shift
      elsif left.first
        out << left.shift
      end
    end
    out
  end
  
  # same algorithm but instead preserves the input arrays
  def self.merge left, right
    out = []
    len = left.size + right.size
    left_i = 0
    right_i = 0
    until left_i + right_i == len - 1 do
      if left[left_i] && right[right_i] && left[left_i] < right[right_i]
        out << left[left_i]
        left_i += 1
      elsif right[right_i]
        out << right[right_i]
        right_i += 1
      elsif left[left_i]
        out << left[left_i]
        left_i += 1
      end
    end
    out
  end
  
end

{
  [[3, 4, 6, 10, 11, 15], [1, 5, 8, 12, 14, 19]] => [1, 3, 4, 5, 6, 8, 10, 11, 12, 14, 15, 19],
  [[1, 2, 3], [4, 5, 6]] => [1, 2, 3, 4, 5, 6],
  [[], []] => [],
  [[1], []] => [1],
  [[], [1]] => [1],
  [[4, 5, 6], [1, 2, 3]] => [1, 2, 3, 4, 5, 6],
}.each do |input, output|
  [
    Merger.merge(input[0], input[1]),
    Merger.merge!(input[0], input[1]),
  ].each do |result|
    if result == output
      puts "PASS"
    else
      puts "FAIL given #{input.join(' ')}, expected #{output.join(' ')} but got #{result.join(' ')}"
    end
  end
end
