require 'io/console'
require './vector'
require './body'

class Asteroids
  attr_reader :playing
  def initialize
    @width = 80
    @height = 40
    @asteroids = []
    @bullets = []
    @ship = Ship.new [@width/2, @height/2], Vector.new(0,0)
    @score = 0
    @playing = true
    @can_fire = true
  end
  
  def tick
    # remove asteroids that are off the board
    @asteroids = @asteroids.select { |a| in_bounds?(a.pos[0], a.pos[1]) }
    # if any @bullets collide with asteroids, remove them (TODO break them)
    # TODO increase score for each one, once per asteroid. remove the bullet.
    @asteroids = @asteroids.select { |a| @bullets.none? { |b| a.collides_with? b } }
    # make the ship wrap around the board
    @ship.pos[0] = 0 if @ship.pos[0] > @width
    @ship.pos[1] = 0 if @ship.pos[1] > @height
    @ship.pos[0] = @width-1 if @ship.pos[0] < 0
    @ship.pos[1] = @height-1 if @ship.pos[1] < 0
    # make sure there are enough asteroids
    @asteroids << Asteroid.new(random_point_on_edge, random_vector(0.2)) while @asteroids.size < 5
    @asteroids.each &:tick!
    @ship.tick!
    @bullets.each &:tick!
    # if @ship collides with @asteroid, game over
    @playing = @asteroids.none? { |a| a.collides_with? @ship }
    @can_fire = true
  end
  
  def display
    board = Array.new(@height).map { Array.new(@width) }
    (@asteroids + [@ship] + @bullets).each do |body|
      body.tiles.each do |x, y|
        if in_bounds? x, y
          board[y][x] ||= body.char
        end
      end
    end
    system 'clear'
    board.each do |row|
      row.each { |col| print col || " " }
      print "\n"
    end
    print "\n"
  end
  
  def turn direction=1
    @ship.rotate! direction*5
  end
  
  def fire
    @can_fire = false
    vec = Vector.new(@ship.heading.x, @ship.heading.y).resize 2
    @bullets << Bullet.new(@ship.pos, vec + @ship.vector)
  end
  
  def thrust
    @ship.thrust
  end
  
  private
  
  def random_point_on_edge
    sides = [0, @width-1, 0, @height-1] # x, x, y, y
    side = rand(0..3)
    out = if side < 2 # East or West
      [sides[side], rand(0..@height-1)]
    else # North or South
      [rand(0..@width-1), sides[side]]
    end
    puts out
    out
  end
  
  def random_vector magnitude
    phi = rand(Math::PI * 2)
    Vector.new Math.cos(phi) * magnitude, Math.sin(phi) * magnitude
  end
  
  def in_bounds? x, y
    x >= 0 && x < @width && y >= 0 && y < @height
  end
end

class Asteroid < Body
  def initialize *args
    @form = [[0,0],[-1,0],[-1,-1],[0,-1],[-1,1],[1,0],[0,1],[1,1],[1,-1]] # 3x3 block
    @char = '#'
    super *args
  end
end

class Bullet < Body
  def initialize *args
    @form = [[0,0]]
    @char = '.'
    super *args
  end
end

class Ship < Body
  def initialize *args
    @form = [[0,0],[-1,0],[-2,0],[1,0],[2,0],[0,1],[0,2]]
    @char = '@'
    super *args
  end
  def thrust amount=0.05
    @vector += (@heading * amount)
    @vector.x = [@vector.x, 1].min
    @vector.y = [@vector.y, 1].min
    @vector.x = [@vector.x, -1].max
    @vector.y = [@vector.y, -1].max
  end
end

system "stty -echo"
game = Asteroids.new
last_frame = Time.now
loop do
  if !game.playing
    break
  end
  system "stty raw"
  key = STDIN.read_nonblock(1) rescue nil
  system "stty -raw"
  if key == 'w'
    game.thrust
  elsif key == 's'
    game.fire
  elsif key == 'a'
    game.turn -1
  elsif key == 'd'
    game.turn 1
  elsif key == 'q'
    exit
  end
  now = Time.now
  if now - last_frame > 0.1
    game.tick
    game.display
    last_frame = now
  end
end
