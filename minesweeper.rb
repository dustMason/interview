require 'io/console'

# To play, run `ruby minesweeper.rb`
#
# Controls
# - W-A-S-D: move player
# - Enter: explore current tile
# - Space: place flag on current tile
# - q: exit game

class Minesweeper
  attr_reader :playing
  
  MINE = -1
  
  # A static list of 8 movements relative to any given tile (up, down, left,
  # right and 4 diagonals).
  MOVES = [-1, 0, 1].repeated_combination(2).to_a.flat_map do |a|
    a.permutation.to_a 
  end.uniq - [[0, 0]]
  
  # size = width and height of square game board
  # mines = number of mines to randomly place within the board
  def initialize size=6, mines=20
    @size = size
    @mines = mines
  end
  
  def start!
    @board = Array.new(@size**2)
    @board.fill 0
    
    # Randomly assign the given number of mines to the board. Array#sample ensures
    # no repeats so this is guaranteed to place the correct number of mines.
    (0..(@size**2)).to_a.sample(@mines).each { |i| @board[i] = MINE }
    
    # Walk the entire board and calculate + store the adjacency counts for each
    # tile. This is a costly operation so we only do it once, before the game starts.
    @board = @board.map.with_index do |s, i|
      if s == MINE
        MINE
      else
        neighbs = neighboring_tile_indices(i) 
        count = neighbs.reduce(0) { |acc, j| if @board[j] == MINE then acc + 1 else acc end }
        count
      end
    end
    
    # Initialize the game state.
    @cursor = 0
    @uncovered = []
    @covered_count = @size**2
    @flags = []
    @moves = 0
    @playing = true
    display
  end
  
  # `touch` is called when the player uncovers a tile. If they've chosen a mine,
  # the game immediately ends. On an empty tile, their view of the board expands
  # outward until it is surrounded by mines or the edges of the board. Uncovered
  # tiles display the count of adjacent mines.
  def touch index=nil
    index ||= @cursor
    @moves += 1
    if @board[index] == MINE
      @uncovered[index] = true
      puts "BOOM!"
      @playing = false
    elsif !@uncovered[index]
      @uncovered[index] = true
      @covered_count -= 1
      breadth_first_search(index) if @board[index] == 0
      display
      if @covered_count == @mines
        puts "YOU WIN! #{@moves} moves"
        @playing = false
      end
    end
  end
  
  # The player may plant flags to remind them where they believe the mines are.
  def flag index=nil
    index ||= @cursor
    @flags[index] = !@flags[index]
    display
  end
  
  # Clear the screen and completely redraw the game board. This could be optimized.
  def display
    system 'clear'
    print "\n"
    i = 0
    @size.times do |y|
      @size.times do |x|
        print "#{tile_to_s(i)} "
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
  
  # An implementation of BFS to perform the "flood-fill" that happens when uncovering
  # an empty tile. This also uncovers the tiles at the outer edge of the fill in
  # order to reveal the adjacency counts.
  def breadth_first_search source_index
    neighbors = neighboring_tile_indices source_index
    until neighbors.empty? do
      neighbor = neighbors.pop
      if @board[neighbor] != MINE && !@uncovered[neighbor]
        neighbors += neighboring_tile_indices(neighbor) if @board[neighbor] == 0
        @covered_count -= 1
        @uncovered[neighbor] = true
      end
    end
  end
  
  def tile_to_s index
    if @cursor == index
      "🙋"
    elsif @flags[index]
        "⛳"
    elsif @uncovered[index]
      if @board[index] == MINE 
        "💣"
      elsif @board[index] == 0
        "·"
      else
        @board[index].to_s
      end
    else
      "▧"
    end
  end
  
  def random_tile
    rand(0..(@size**2)-1)
  end
  
  # A helper method to validate a given relative coordinate. Returns nil if the
  # resulting move would be off the game board.
  def relative index, x, y
    target = index + x + (y * @size)
    if ((target % @size) - (index % @size)).abs > 1
      target = nil
    elsif target < 0 || target > (@size**2) - 1
      target = nil
    end
    target
  end
  
  def neighboring_tile_indices index
    MOVES.map { |x, y| relative index, x, y }.compact
  end
end

game = Minesweeper.new(60, 100)
game.start!
while game.playing do
  dir = STDIN.getch
  if dir == 'w'
    game.move 0, -1
  elsif dir == 'a'
    game.move -1, 0
  elsif dir == 's'
    game.move 0, 1
  elsif dir == 'd'
    game.move 1, 0
  elsif dir.ord == 13 # return
    game.touch
  elsif dir.ord == 32 # space
    game.flag
  elsif dir == 'q'
    exit
  end
end
