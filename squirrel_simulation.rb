def min_distance height, width, tree, squirrel, nuts
  distance_saved = -1 * (height + width)
  total_distance = 0
  
  nuts.each.with_index do |nut, i|
    to_squirrel = dist(squirrel, nut)
    to_tree = dist(tree, nut)
    total_distance += to_tree * 2
    distance_saved = [(to_tree - to_squirrel), distance_saved].max
  end
  
  total_distance - distance_saved
end

def dist from, to
  (from[0] - to[0]).abs + (from[1] - to[1]).abs
end

{
  [5, 7, [2,2], [4,4], [[3,0], [2,5]]] => 12,
  [1, 3, [0,1], [0,0], [[0,2]]] => 3
}.each do |input, output|
  result = min_distance *input
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
