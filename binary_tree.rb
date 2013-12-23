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

  def self.print_in_order node
    return if node.nil?
    print_in_order node.left
    print node.value, " "
    print_in_order node.right
  end

  def self.print_post_order node
    return if node.nil?
    print_post_order node.left
    print_post_order node.right
    print node.value, " "
  end

end

bt = BT::Node.new(1, BT::Node.new(2, BT::Node.new(4), BT::Node.new(5)), BT::Node.new(3, BT::Node.new(7), BT::Node.new(8)))
bt2 = BT::Node.new(1, BT::Node.new(2, BT::Node.new(4, BT::Node.new(2, BT::Node.new(3, BT::Node.new(4))), BT::Node.new(5)), BT::Node.new(3, BT::Node.new(7), BT::Node.new(8))))

[bt, bt2].each do |tree|
  puts BT::size(tree) #=> 7
  puts BT::height(tree) #=> 3
  BT::print_in_order tree
  puts " "
  BT::print_post_order tree
  puts " "
end
