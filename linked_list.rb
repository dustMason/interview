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

end

test_sll_list = SLL::Node.new(1, SLL::Node.new(2, SLL::Node.new(3, SLL::Node.new(4))))

# puts SLL::insert(test_sll_list, 4).inspect
puts SLL::delete(test_sll_list, 3).inspect
