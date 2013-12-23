module SLL

  class Node
    attr_accessor :value, :next_node
    def initialize value, next_node=nil
      @value = value
      @next_node = next_node
    end
  end

  def self.insert node, value
    Node.new(value, node)
  end

  def self.delete node, value
    return nil if node.nil?
    node.next_node = delete(node.next_node, value)
    if node.value == value then node.next_node else node end
  end

  # only useful if outside refs to the nodes exist
  def self.split! node, value
    return nil if node.nil?
    node.next_node = nil if node.value == value
    split! node.next_node, value
  end

  def self.middle node

  end

end

list = SLL::Node.new(0)
50.times { |i| list = SLL::insert list, i % 5 }

# puts SLL::insert(list, 4).inspect
puts SLL::delete(list, 3).inspect

# SLL::split!(list, 3)
# puts list.inspect
# SLL::print_all_nodes
