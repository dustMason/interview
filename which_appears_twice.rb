# I have an array of n+1 numbers. Every number in the range 1..n appears once
# except for one number that appears twice. Write a function for finding the
# number that appears twice.

class DoubleFinder
  def self.find numbers=[]
    if numbers.empty?
      return nil
    end
    sum = 0
    numbers.each_with_index do |n, i|
      len = i+1
      expected_sum = (len * (len+1)) / 2
      sum += n
      if sum != expected_sum
        return n
      end
    end
    return nil
  end
end


{
  [1, 1, 2, 3, 4] => 1,
  [1, 2, 2, 3, 4] => 2,
  [1, 2, 3, 3, 4] => 3,
  [1, 2, 3, 4, 4] => 4,
  [] => nil,
  [1] => nil,
  [1, 2, 3, 4, 5, 6] => nil,
}.each do |input, output|
  result = DoubleFinder.find input
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
