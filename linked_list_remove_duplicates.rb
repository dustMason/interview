module SLL
  
  class Node
    attr_accessor :value, :next_node
    def initialize value, next_node=nil
      @value = value
      @next_node = next_node
    end
    
    def to_a
      out = [value]
      _next = next_node
      until _next.nil? do
        out << _next.value
        _next = _next.next_node
      end
      out
    end
  end
  
  def self.delete_duplicates node
    raise "must provide a root node" unless node
    tail = node
    _next = tail.next_node
    until _next.nil? do
      if _next.value != tail.value
        tail.next_node = _next
        tail = _next
      else
        tail.next_node = nil
      end
      _next = _next.next_node
    end
    node
  end
  
end

{
  [1] => [1],
  [1, 1, 2] => [1, 2],
  [1, 2, 3] => [1, 2, 3],
  [1, 1, 2, 3, 3] => [1, 2, 3],
  [1, 2, 2, 3] => [1, 2, 3]
}.each do |input, output|
  list = input.map { |n| SLL::Node.new(n) }
  list.each_with_index { |n, i| list[i-1].next_node = n if i > 0 }
  result = SLL::delete_duplicates list[0]
  if result.to_a == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
