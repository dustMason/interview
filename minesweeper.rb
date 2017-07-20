require 'colorize'
require 'io/console'

class Minesweeper
  MINE = -1
  attr_reader :alive
  
  def initialize size=6, mines=20
    @size = size
    @mines = mines
  end
  
  def start!
    @board = Array.new(@size**2)
    @board.fill 0
    
    # place the mines randomly
    @mines.times do
      mine = random_square
      mine = random_square until @board[mine] == 0
      @board[mine] = MINE
    end
    
    # calculate the adjacency counts for each square
    @board = @board.map.with_index do |s, i|
      if s == MINE
        MINE
      else
        neighbs = neighboring_square_indices(i) 
        count = neighbs.reduce(0) { |acc, j| if @board[j] == MINE then acc + 1 else acc end }
        count
      end
    end
    
    # init the game state
    @cursor = 0
    @uncovered = []
    @moves = 0
    @alive = true
    display
  end
  
  def touch index=nil
    index ||= @cursor
    @moves += 1
    if @board[index] == MINE
      @uncovered[index] = true
      @alive = false
      puts "BOOM!"
    elsif !@uncovered[index]
      @uncovered[index] = true
      breadth_first_search(index) if @board[index] == 0
    end
    display
  end
  
  def display
    system 'clear'
    print "\n"
    i = 0
    @size.times do |y|
      @size.times do |x|
        print "#{square_to_s(i)} "
        i += 1
      end
      print "\n"
    end
    print "\n"
  end
  
  def move x, y
    dest = relative(@cursor, x, y)
    @cursor = dest if dest
    display
  end
  
  private
  
  def breadth_first_search source_index
    neighbors = neighboring_square_indices source_index
    neighbors.each do |neighbor| 
      if @board[neighbor] != MINE && !@uncovered[neighbor]
        @uncovered[neighbor] = true
        breadth_first_search(neighbor) if @board[neighbor] == 0
      end
    end
  end
  
  def square_to_s index
    str = if @uncovered[index]
      if @board[index] == MINE then "•" else @board[index].to_s end
    else
      "-"
    end
    if index == @cursor
      str = str.colorize(color: :black, background: :light_blue)
    elsif str != '-' && str != '0'
      str = str.colorize(color: :red)
    end
    str
  end
  
  def random_square
    rand(0..(@size**2)-1)
  end
  
  def relative index, x, y
    # calculate the coordinate, then invalidate it if its off the map
    target = index + x + (y * @size)
    if ((target % @size) - (index % @size)).abs > 1
      target = nil
    elsif target < 0 || target > (@size**2) - 1
      target = nil
    end
    target
  end
  
  def neighboring_square_indices index
    # all adjacent 'legal' squares
    moves = [-1, 0, 1].repeated_combination(2).to_a.flat_map { |a| a.permutation.to_a }.uniq - [[0, 0]]
    moves.map { |x, y| relative index, x, y }.compact
  end
end

game = Minesweeper.new(60, 90)
game.start!
while game.alive do
  dir = STDIN.getch
  if dir == 'w'
    game.move 0, -1
  elsif dir == 'a'
    game.move -1, 0
  elsif dir == 's'
    game.move 0, 1
  elsif dir == 'd'
    game.move 1, 0
  elsif dir == 'u'
    game.touch
  elsif dir == 'q'
    exit
  end
end
