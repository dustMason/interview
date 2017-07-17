# Hooray! It's opposite day. Linked lists go the opposite way today. Write a
# function for reversing a linked list. Do it in-place.
# 
# Your function will have one input: the head of the list.
# 
# Your function should return the new head of the list.

class LinkedListNode
  attr_accessor :value, :next
  def initialize value
    @value = value
    @next = nil
  end
  
  # debug and testing:
  
  def join sep
    self.values.join sep
  end
  
  def values
    _n = self.next
    out = [self.value]
    until _n.nil? do
      out << _n.value
      _n = _n.next
    end
    out
  end
end

def reverse head
  _node = head
  _prev = nil
  until _node.nil? do
    _next = _node.next
    _node.next = _prev
    _prev = _node
    _node = _next
  end
  return _prev
end

{
  %w{a b c} => %w{c b a},
  %w{} => nil,
  %w{a} => %w{a},
  %w{a b c d e f} => %w{f e d c b a},
}.each do |input, output|
  nodes = input.map { |v| LinkedListNode.new(v) }
  nodes = nodes.map.with_index do |n, i|
    n.next = nodes[i+1] if nodes[i+1]
    n
  end
  head = reverse nodes[0]
  result = head.values if head
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input}, expected #{output} but got #{result}"
  end
end
