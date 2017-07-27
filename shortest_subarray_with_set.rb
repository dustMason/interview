require 'set'

def shortest_subarray_with set, arr
  window_start = 0
  empty_hash = Hash[set.to_a.zip(Array.new(set.size, 0))]
  shortest = nil
  
  until window_start == arr.size do
    counts = empty_hash.dup
    seen = Set.new
    _start = 0
    _end = 0
    
    arr[window_start..-1].each_with_index do |a, i|
      if counts.has_key? a
        counts[a] += 1
        seen.add a
        if seen.size == set.size
          _end = i + window_start
          break
        end
      end
    end
    
    arr[window_start.._end].each_with_index do |a, i|
      if counts.has_key? a
        counts[a] -= 1
        if counts[a] == 0
          _start = i + window_start
          break
        end
      end
    end
    
    shortest ||= arr[_start.._end]
    
    if _end - _start > 0 && _end - _start < shortest.size
      shortest = arr[_start.._end]
    end
    
    window_start += 1
  end
  
  shortest
end

{
  [[1, 2, 3], [1, 2, 2, 5, 4, 1, 1, 1, 2, 2, 3, 3]] => [1, 2, 2, 3],
  [[1, 4, 5], [1, 2, 2, 5, 4, 1, 1, 1, 2, 2, 3, 3]] => [5, 4, 1],
  [[1, 2, 4, 5, 10], [1, 2, 2, 5, 4, 10, 1, 1, 1, 2, 2, 3, 3]] => [2, 5, 4, 10, 1]
}.each do |input, output|
  result = shortest_subarray_with input[0], input[1]
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input}, expected #{output}, got #{result}"
  end
end
