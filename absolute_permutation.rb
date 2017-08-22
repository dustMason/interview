# https://www.hackerrank.com/challenges/absolute-permutation

require 'set'

def absolute_permutation limit, k
  out = []
  set = (1..limit).to_set
  
  limit.times do |i|
    if set.include? i+1-k
      out << i+1-k
      set.delete i+1-k
    elsif set.include? i+1+k
      out << i+1+k
      set.delete i+1+k
    else
      return -1
    end
  end
  
  return out.join " "
end

{
  [2, 1] => [2, 1],
  [3, 0] => [1, 2, 3],
  [3, 2] => -1
}.each do |(limit, k), output|
  result = absolute_permutation limit, k
  if result == output
    puts "pass"
  else
    puts "fail given #{[limit, k]} got #{result} expected #{output}"
  end
end
