class Vector
  attr_accessor :x, :y
  
  def initialize x, y
    @x = x
    @y = y
  end
  
  def length
    Math.sqrt x * x + y * y
  end
  
  def resize new_length
    self * (new_length / length)
  end
  
  def rotate! degrees
    radians = degrees * Math::PI/180
    cos = Math.cos radians
    sin = Math.sin radians
    self.x = x*cos - y*sin
    self.y = x*sin + y*cos
  end
  
  def * n
    self.class.new(x * n, y * n)
  end
  
  def + vector
    self.class.new(x + vector.x, y + vector.y)
  end
end
