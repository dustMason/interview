# abstracted the solution to find intersections between two shapes
# of any number of dimensions

class Shape
  attr_accessor :dimensions
  def initialize *dimensions
    @dimensions = dimensions.each_slice(2).map do |start, length|
      { start: start, length: length, end: start + length }
    end
  end
  
  def to_s
    dimensions.map { |d| [d[:start], d[:length]] }.to_s
  end
end

class Love
  def self.intersection l, r
    does_intersect = r.dimensions.each_with_index.all? do |dim, i|
      l.dimensions[i][:end] >= dim[:start] && l.dimensions[i][:start] <= dim[:end]
    end
    
    if does_intersect
      starts = l.dimensions.each_with_index.map do |dim, i|
        [dim[:start], r.dimensions[i][:start]].max
      end
      lengths = l.dimensions.each_with_index.map do |dim, i|
        [dim[:end], r.dimensions[i][:end]].min - starts[i]
      end
      
      if lengths.any? { |l| l == 0 }
        return nil
      else
        return Shape.new(*starts.zip(lengths).flatten)
      end
    else
      return nil
    end
  end
end

{
  [Shape.new(0, 2, 1, 4), Shape.new(1, 3, 3, 3)] => Shape.new(1, 1, 3, 2), # A
  [Shape.new(0, 2, 1, 2), Shape.new(3, 1, 1, 2)] => nil, # B
  [Shape.new(0, 2, 1, 2), Shape.new(2, 2, 1, 2)] => nil, # C
  [Shape.new(0, 4, 1, 3), Shape.new(1, 2, 2, 1)] => Shape.new(1, 2, 2, 1), # D
  [Shape.new(0, 2, 1, 4), Shape.new(1, 3, 2, 3)] => Shape.new(1, 1, 2, 3), # E
  [Shape.new(0, 2), Shape.new(1, 3)] => Shape.new(1, 1),
  [Shape.new(0, 2, 1, 4, 1, 4), Shape.new(1, 3, 2, 3, 2, 3)] => Shape.new(1, 1, 2, 3, 2, 3),
}.each do |input, output|
  result = Love.intersection input[0], input[1]
  if result.to_s == output.to_s
    puts "pass"
  else
    puts "given #{input.map(&:to_s)}, expected #{output} but got #{result}"
  end
end
