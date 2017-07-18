# I have an array of n+1 numbers. Every number in the range 1..n appears once
# except for one number that appears twice. Write a function for finding the
# number that appears twice.

class DoubleFinder
  def self.find numbers=[]
    if numbers.empty?
      return nil
    end
    sum = numbers.reduce &:+
    if sum == (numbers.size * (numbers.size+1)) / 2
      # there are no doubles, the sum indicates there is one of each number
      return nil
    else
      # without the one double, the sum would be against 1..n
      return sum - (((numbers.size-1) * numbers.size) / 2)
    end
    
  end
end

{
  [1, 1, 2, 3, 4] => 1,
  [1, 2, 2, 3, 4] => 2,
  [1, 2, 3, 3, 4] => 3,
  [1, 2, 3, 4, 4] => 4,
  [4, 5, 5, 3, 2, 1] => 5,
  [5, 4, 3, 2, 1, 1] => 1,
  [6, 6, 5, 4, 3, 2, 1].shuffle => 6,
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
    puts "-"*80
  end
end
