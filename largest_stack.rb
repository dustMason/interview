# Use your Stack class to implement a new class MaxStack with a function
# get_max() that returns the largest element in the stack. get_max() should not
# remove the item. Your stacks will contain only integers.

require 'forwardable'

class Stack
  extend Forwardable
  def_delegators :@items, :push, :pop
  def initialize
    @items = []
  end
end

class MaxStack
  def initialize
    @stack = Stack.new
  end
  
  def push value
    @max = value if @max.nil? || value > @max
    item = [value, @max]
    @stack.push item
  end
  
  def pop
    item = @stack.pop
    @max = item[1]
    item[0]
  end
  
  def get_max
    @max
  end
end

max = MaxStack.new
(1..5).to_a.each { |n| max.push n * 3 }
puts max.get_max == 15
3.times { max.pop }
puts max.get_max == 9
