class Body
  attr_accessor :form
  attr_reader :pos, :vector, :char, :heading
  def initialize pos, vector, heading=nil
    @pos = pos
    @vector = vector
    @heading = heading || Vector.new(0,1)
  end
  
  def tiles
    form.map do |x, y|
      [(x + @pos[0]).floor, (y + @pos[1]).floor]
    end
  end
  
  def rotate! degrees
    origin = form[0]
    radians = degrees * Math::PI/180
    cos = Math.cos(radians)
    sin = Math.sin(radians)
    self.form = [origin] + form[1..-1].map do |x, y|
      x2 = x - origin[0]
      y2 = y - origin[1]
      [
        x2*cos - y2*sin + origin[0],
        x2*sin + y2*cos + origin[1]
      ]
    end
    @heading.rotate! degrees
  end
  
  def tick!
    @pos = [@pos[0] + @vector.x, @pos[1] + @vector.y]
  end
  
  def collides_with? body
    (body.tiles & self.tiles).any?
  end
end
