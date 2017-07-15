# Delete a node from a singly-linked list, given only a variable pointing to that node.

class LinkedListNode
  attr_accessor :value, :next

  def initialize(value)
    @value = value
    @next = nil
  end
  
  def to_s
    _next = @next
    out = "#{@value} -> "
    until _next.nil? do
      out += "#{_next.value}"
      _next = _next.next
      out += " -> " if _next
    end
    out
  end
end

def delete_node node
  if node.next 
    node.value = node.next.value
    if node.next.next
      node.next = node.next.next
    else
      node.next = nil
    end
  else
    raise 'Cannot delete a node with no `next`'
  end
end

{
  [%w{a b c}, 0] => 'b -> c',
  [%w{a b c}, 1] => 'a -> c',
  # [%w{a b c}, 2] => 'a -> b', # raises error
  [%w{a b c d e f g}, 3] => 'a -> b -> c -> e -> f -> g',
  [%w{a b c d e f g}, 0] => 'b -> c -> d -> e -> f -> g',
  [%w{a b c d e f g}, 5] => 'a -> b -> c -> d -> e -> g',
}.each do |input, output|
  nodes = input[0].map { |v| LinkedListNode.new(v) }
  nodes.each_with_index { |node, i| node.next = nodes[i+1] }
  delete_node nodes[input[1]]
  result = nodes[0].to_s
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input.join('-')}, expected #{output} but got #{result}"
  end
end
