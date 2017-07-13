require 'forwardable'

class Stack
  extend Forwardable
  def_delegators :@items, :push, :pop, :empty?
  def initialize
    @items = []
  end
  def to_s
    @items.join "-"
  end
end

class Queue
  def initialize
    @in = Stack.new
    @out = Stack.new
    @next = nil
  end
  
  def enqueue item
    until @out.empty? do
      @in.push @out.pop
    end
    @in.push item
  end
  
  def dequeue
    item = nil
    if @in.empty?
      item = @out.pop
    else
      until @in.empty? do
        @out.push item if item
        item = @in.pop
      end
    end
    item
  end
end

q = Queue.new
out = []
[1, 2, 3, 4, 5].each { |n| q.enqueue n }
3.times { out << q.dequeue }
[6, 7, 8, 9, 0].each { |n| q.enqueue n }
7.times { out << q.dequeue }

expected = [1, 2, 3, 4, 5, 6, 7, 8, 9, 0] 
if out != expected
  puts "FAIL"
  puts "get       #{out.join '-'}"
  puts "expected  #{expected.join '-'}"
else
  puts "PASS"
end
