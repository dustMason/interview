# ruby's built in sort method uses quicksort, so this isn't totally optimal
# given that arr1 and arr2 are sorted. if the arrays were not sorted, however,
# this would be a good solution
def find_median_sorted_quicksort arr1, arr2
  joined = (arr1 + arr2).sort
  if joined.size % 2 == 0
    return joined[(joined.size/2)-1..(joined.size/2)].reduce(&:+) / 2.0
  else
    return joined[joined.size/2]
  end
end

# the following solution gives the smaller of O(log(arr1.size)) or O(log(arr2.size))
# because we perform what amounts to a binary search on a set with a size equal
# to the smaller of the two inputs.

FIXNUM_MAX = (2**(0.size * 8 -2) -1)
FIXNUM_MIN = -(2**(0.size * 8 -2))

def find_median_sorted arr1, arr2
  if arr1.size < arr2.size # arr2 should always be shorter, if possible
    return find_median_sorted arr2, arr1
  end
  
  if arr2.empty? # just return the median of arr1
    return (arr1[(arr1.size-1)/2] + arr1[arr1.size/2]) / 2.0
  end
  
  # binary search for the correct place to "cut" the two arrays, then get median of
  # the numbers that span those two "cuts"
  low = 0
  high = arr2.size * 2
  while low <= high do
    middle2 = (low + high) / 2
    middle1 = arr1.size + arr2.size - middle2
    left1 = if middle1 == 0 then FIXNUM_MIN else arr1[(middle1 - 1)/2] end
    left2 = if middle2 == 0 then FIXNUM_MIN else arr2[(middle2 - 1)/2] end
    right1 = if middle1 == arr1.size * 2 then FIXNUM_MAX else arr1[middle1/2] end
    right2 = if middle2 == arr2.size * 2 then FIXNUM_MAX else arr2[middle2/2] end
    if left1 > right2
      low = middle2 + 1
    elsif left2 > right1
      high = middle2 - 1
    else
      return ([left1, left2].max + [right1, right2].min) / 2.0
    end
  end
  
  return -1
end

{
  [[1, 3], [2]] => 2,
  [[1, 2], [3, 4]] => 2.5,
  [[], [1]] => 1
}.each do |input, output|
  [
    find_median_sorted_quicksort(input[0], input[1]),
    find_median_sorted(input[0], input[1])
  ].each do |result|
    if result == output
      puts "pass"
    else
      puts "fail"
      puts "given #{input}, expected #{output}, got #{result}"
    end
  end
end
