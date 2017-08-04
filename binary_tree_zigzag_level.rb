class TreeNode
  attr_accessor :val, :left, :right
  def initialize val
    @val = val
  end
end

#
# https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/description/

# Given a binary tree, return the zigzag level order traversal of its nodes'
# values. (ie, from left to right, then right to left for the next level and
# alternate between).

# @param {TreeNode} root
# @return {Integer[][]}
def zigzag_level_order root
  return [] unless root
  out = []
  d_queue = [root]
  zig = true
  until d_queue.empty? do
    size = d_queue.size
    zig = !zig
    row = []
    while size > 0 do
      if zig
        node = d_queue.shift
        row << node.val
        d_queue << node.right if node.right
        d_queue << node.left if node.left
      else
        node = d_queue.pop
        row << node.val
        d_queue.unshift(node.left) if node.left
        d_queue.unshift(node.right) if node.right
      end
      size -= 1
    end
    out << row
  end
  out
end

tree1 = TreeNode.new 3
tree1.left = TreeNode.new 9
tree1.right = TreeNode.new 20
tree1.right.left = TreeNode.new 15
tree1.right.right = TreeNode.new 7

tree2 = TreeNode.new 1
tree2.left = TreeNode.new 2

tree3 = TreeNode.new 1
tree3.left = TreeNode.new 2
tree3.right = TreeNode.new 3
tree3.left.left = TreeNode.new 4
tree3.left.right = TreeNode.new 5

tree4 = TreeNode.new 1
tree4.left = TreeNode.new 2
tree4.left.left = TreeNode.new 3
tree4.left.left.left = TreeNode.new 4
tree4.left.left.left.left = TreeNode.new 5

tree5 = TreeNode.new 1
tree5.left = TreeNode.new 2
tree5.left.left = TreeNode.new 4
tree5.right = TreeNode.new 3
tree5.right.right = TreeNode.new 5

{
  tree1 => [[3], [20,9], [15,7]],
  tree2 => [[1], [2]],
  tree3 => [[1], [3,2], [4,5]],
  tree4 => [[1], [2], [3], [4], [5]],
  tree5 => [[1], [3,2], [4,5]]
}.each do |input, output|
  result = zigzag_level_order input
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
