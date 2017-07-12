class Rect
  attr_accessor :x, :y, :width, :height
  def initialize x, y, width=nil, height=nil
    @x = x
    @y = y
    @width = width
    @height = height
  end
  def x2
    x + width
  end
  def y2
    y + height
  end
  def to_s
    [x, y, width, height].join "/"
  end
end

class Love
  def self.intersection l, r
    horizontal = false
    vertical = false
    if (l.x + l.width >= r.x) && (l.x <= r.x + r.width)
       horizontal = true
    end
    
    if (l.y + l.height >= r.y) && (l.y <= r.y + r.height)
      vertical = true
    end
    
    if horizontal && vertical
      intersect = Rect.new(
        [l.x, r.x].max,
        [l.y, r.y].max,
      )
      intersect.width = [l.x2, r.x2].min - intersect.x
      intersect.height = [l.y2, r.y2].min - intersect.y
      if intersect.height == 0 || intersect.width == 0
        return nil
      else
        return intersect
      end
    else
      return nil
    end
  end
end

{
  [Rect.new(0, 1, 2, 2), Rect.new(3, 1, 1, 2)] => nil,
  [Rect.new(0, 1, 2, 2), Rect.new(2, 1, 2, 2)] => nil,
  [Rect.new(0, 1, 2, 4), Rect.new(1, 3, 3, 3)] => Rect.new(1, 3, 1, 2),
  [Rect.new(0, 1, 4, 2), Rect.new(1, 2, 2, 1)] => Rect.new(1, 2, 2, 1)
}.each do |input, output|
  result = Love.intersection input[0], input[1]
  if result.to_s == output.to_s
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
