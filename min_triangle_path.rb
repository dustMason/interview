def minimum_total triangle
  layers = triangle.size
  sums = triangle.last
  layer = layers-2
  while layer >= 0 do
    i = 0
    while i <= layer do
      sums[i] = [sums[i], sums[i+1]].min + triangle[layer][i]
      i += 1
    end
    layer -= 1
  end
  sums[0]
end

{
  [[2],
  [3, 4],
 [6, 5, 7],
[4, 1, 8, 3]] => 11,
  [[2],
  [9, 1],
 [1, 1, 9],
[1, 1, 1, 1]] => 5,
}.each do |input, output|
  result = minimum_total input
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
