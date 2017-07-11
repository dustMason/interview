# Given a list of integers, find the highest product you can get from three of the integers.
# The input list_of_ints will always have at least three integers.

class Naive
  def self.highest_product ints
    highest_product = 0
    highest = []
    ints.each do |n|
      if highest.size < 3
        highest << n
        highest.sort!
      elsif n > highest[0]
        highest[0] = n
        highest.sort!
      end
    end
    highest.reduce &:*
  end
end

class Optimized
  def self.highest_product ints
    raise 'Input must have at least 3 ints' unless ints.size > 2
    
    hi = [ints[0], ints[1]].max
    lo = [ints[0], ints[1]].min
    
    hi_product2 = ints[0]* ints[1]
    lo_product2 = ints[0]* ints[1]
    
    hi_product3 = ints[0]* ints[1]* ints[2]
    
    ints.each_with_index do |n, i|
      next if i < 2 # already set up first 3
      
      hi_product3 = [
        hi_product3,
        n * hi_product2,
        n * lo_product2
      ].max
      
      hi_product2 = [
        hi_product2,
        n * hi,
        n * lo
      ].max
      
      lo_product2 = [
        lo_product2,
        n * hi,
        n * lo
      ].min
      
      hi = [hi, n].max
      
      lo = [lo, n].max
    end
    
    hi_product3
  end
end

{
  [1, 2, 3, 4] => 24,
  [1, 1, 1, 1] => 1,
  [100, 101, 102, 103, 104] => 1_092_624,
  [0, 0, 0] => 0,
  [0, 100, 1000] => 0,
  [-5, -20, 1000, -300] => 6_000_000,
}.each do |input, output|
  [Naive, Optimized].each do |klass|
    result = klass.highest_product input
    if result == output
      puts "pass"
    else
      puts "#{klass}: given #{input}, expected #{output} but got #{result}"
    end
  end
end
