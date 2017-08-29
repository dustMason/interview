# https://www.hackerrank.com/challenges/journey-to-the-moon/problem

class DisjointSet
  def initialize
    @members = {}
  end
  
  def add value
    @members[value] = Node.new value
  end
  
  def find_set value
    find_root_node(@members[value]).value
  end
  
  def union value1, value2
    root1 = find_root_node @members[value1]
    root2 = find_root_node @members[value2]
    if root1.rank >= root2.rank
      root2.parent = root1
      root2.rank += 1
    else
      root1.parent = root2
    end
  end
  
  private
  
  def find_root_node node
    node = node.parent until node.parent == node
    return node
  end
end

class Node
  attr_accessor :value, :parent, :rank
  def initialize value
    @value = value
    @parent = self
    @rank = 0
  end
end

def solve n, pairs
  set = DisjointSet.new
  n.times { |i| set.add i }
  pairs.each { |(a, b)| set.union a, b }
  sets = n.times.map { |n| set.find_set n }.group_by(&:to_i).values.map(&:size)
  sum = 0
  sets.reduce(0) { |acc, s| out = acc + (sum * s); sum += s; out }
end

{
  [5, [[0,1],[2,3],[0,4]]] => 6
}.each do |(n, pairs), output|
  result = solve n, pairs
  if output == result
    puts "pass"
  else
    puts "fail given #{[n, pairs]} got #{result} expected #{output}"
  end
end
