# Design and implement a TwoSum class. It should support the following operations:
# add and find.
# 
# add - Add the number to an internal data structure. find - Find if there exists
# any pair of numbers which sum is equal to the value.
# 
# For example,

# add(1); add(3); add(5);
# find(4) -> true
# find(7) -> false

# Your TwoSum object will be instantiated and called as such:
# obj = TwoSum.new()
# obj.add(number)
# param_2 = obj.find(value)

require 'set'

class TwoSumWriteOptimized
  def initialize
    @mem = {}
  end

  def add number
    @mem[number] = if @mem.has_key?(number) then 2 else 1 end
    nil
  end

  def find value
    @mem.each do |k, v|
      diff = value - k
      if @mem.has_key? diff
        if k != diff || @mem[diff] == 2
          return true
        end
      end
    end
    return false
  end
end

class TwoSumReadOptimized
  def initialize
    @sum = Set.new
    @set = Set.new
  end

  def add number
    if @set.include? number
      @sum.add number * 2
    else
      @set.each { |n| @sum.add(n + number) }
      @set.add number
    end
    nil
  end

  def find value
    @sum.include? value
  end
end

{
  ['add',1,'add',3,'add',5,'find',4,'find',7] => [true, false],
  ['add',1,'add',1,'add',5,'find',2,'find',7] => [true, false]
}.each do |input, output|
  [TwoSumReadOptimized, TwoSumWriteOptimized].each do |klass|
    two_sum = klass.new
    result = input.each_slice(2).map do |meth, param|
      two_sum.send meth.to_sym, param
    end.compact
    if result == output
      puts "pass"
    else
      puts "fail"
      puts "with #{klass}"
      puts "given #{input}"
      puts "expected #{output}"
      puts "got #{result}"
    end
  end
end
