module BT

  class Node
    attr_accessor :left, :right, :value
    def initialize value, left=nil, right=nil
      @value = value
      @left = left
      @right = right
    end

    def is_leaf?
      @left.nil? && @right.nil?
    end
  end

  def self.size node
    return 0 if node.nil?
    return 1 if node.is_leaf?
    size(node.left) + size(node.right) + 1
  end

  def self.height node
    return 0 if node.nil?
    return 1 if node.is_leaf?
    [height(node.left), height(node.right)].max + 1
  end

end

bt = BT::Node.new(1, BT::Node.new(2, BT::Node.new(4), BT::Node.new(5)), BT::Node.new(3, BT::Node.new(7), BT::Node.new(8)))
bt2 = BT::Node.new(1, BT::Node.new(2, BT::Node.new(4, BT::Node.new(2, BT::Node.new(3, BT::Node.new(4))), BT::Node.new(5)), BT::Node.new(3, BT::Node.new(7), BT::Node.new(8))))

puts BT::size(bt) #=> 7
puts BT::height(bt) #=> 3

puts BT::size(bt2) #=> 10
puts BT::height(bt2) #=> 6
