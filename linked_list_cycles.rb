# You have a singly-linked list and want to check if it contains a cycle. A
# singly-linked list is built with nodes, where each node has:
# 
# node.next—the next node in the list. node.value—the data held in the node. For
# example, if our linked list stores people in line at the movies, node.value
# might be the person's name.
# 
# A cycle occurs when a node’s @next points back to a previous node in the list.
# The linked list is no longer linear with a beginning and end—instead, it cycles
# through a loop of nodes.
# 
# Write a function contains_cycle() that takes the first node in a singly-linked
# list and returns a boolean indicating whether the list contains a cycle.

require 'set'

class LinkedListNode
  attr_accessor :value, :next
  def initialize(value)
    @value = value
    @next = nil
  end
end

# O(n) time and space
def contains_cycle node
  _node = node
  cycle = false
  ids = Set.new
  until _node.nil? do
    if ids.include?(_node.object_id)
      cycle = true
      break
    else
      ids.add _node.object_id
    end
    _node = _node.next
  end
  cycle
end

# O(n) time, O(1) space
def contains_cycle2 node
  hare = tortoise = node
  cycle = false
  until hare.next.nil? do
    hare = hare.next.next
    tortoise = tortoise.next
    if hare == tortoise
      cycle = true
      break
    end
  end
  cycle
end

{
  [%w{a b c}, [0, 1, 1, 2]] => false,
  [%w{a b c d e f g}, [0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6]] => false,
  [%w{a b c d e f g}, [0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 0, 3]] => false,
  [%w{a b c d e f g}, [0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 3, 0]] => true,
  [%w{a b c d e f g}, [0, 1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 3, 1]] => true,
  [%w{a b c}, [0, 1, 1, 2, 2, 0]] => true,
}.each do |input, output|
  nodes = input[0].map { |v| LinkedListNode.new(v) }
  input[1].each_slice(2) { |l, r| nodes[l].next = nodes[r] }
  [
    contains_cycle(nodes[0]),
    contains_cycle2(nodes[0]),
  ].each do |result|
    if result == output
      puts "PASS"
    else
      puts "FAIL given #{input.join(' ')}, expected #{output} but got #{result}"
    end
  end
end
