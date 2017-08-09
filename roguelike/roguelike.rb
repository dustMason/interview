# srand 12345

require 'io/console'
require 'curses'

require './map'
require "./player"
require "./character"
require "./monstrous_compendium"

module Roguelike
  WALL = -2
  DOOR = -1
  OPEN = 0
  TREASURE = 1
  STAIRS = 2
  START = 3
  DEBUG = -100
  HIDDEN = -3
  
  NEIGHBORS = [[0, 1], [0, -1], [1, 0], [-1, 0], [1, 1], [-1, 1], [1, -1], [-1, -1]]
  
  class Game
    attr_reader :playing
    
    def initialize
      @width = 60
      @height = 40
      @map = Map.new @width, @height
      @player = Player.new
      @player.pos = @map.start
      @map.enter *@player.pos
      @characters = {}
      generate_characters!
      init_curses!
      redraw
      @playing = true
    end
    
    def init_curses!
      Curses.init_screen
      Curses.nonl
      Curses.cbreak
      Curses.noecho
      @screen = Curses.stdscr
    end
    
    def redraw
      out = ''
      @screen.clear
      @map.each_tile do |y, x, tile, revealed, end_of_row|
        if revealed
          if @characters[[y, x]]
            out << @characters[[y, x]].to_s
          elsif @player.pos == [y, x]
            out << @player.to_s
          else
            out << tile_to_s(tile)
          end
        else
          out << tile_to_s(HIDDEN)
        end
        out << " "
        out << "\n" if end_of_row
      end
      out << "\n"
      out << "Life: #{@player.life}"
      out << "\n"
      out << "Items: #{@player.inventory.map { |i| i.to_s }}"
      out << "\n"
      out << @status_message if @status_message
      out << "\n"
      @screen.addstr out
      @screen.refresh
    end
    
    def move y, x
      new_pos = [@player.pos[0] + y, @player.pos[1] + x]
      if @characters[new_pos]
        @status_message = @player / @characters[new_pos] # fight!!!
        @characters.delete(new_pos) if @characters[new_pos].life <= 0
        redraw
      elsif @map.enter *new_pos
        @player.pos = new_pos
        redraw
      end
      if @player.life <= 0
        @playing = false # GAME OVER
      end
    end
    
    private
    
    def generate_characters!
      monsters = ObjectSpace.each_object(Class).select { |klass| klass < Monster }
      20.times { @characters[@map.random_location] = monsters.sample.new }
    end
    
    def tile_to_s tile
      {
        WALL => "▩",
        DOOR => "🚪",
        OPEN => " ",
        TREASURE => "$",
        STAIRS => "=",
        START => "^",
        DEBUG => ".",
        HIDDEN => '`'
      }[tile] || ' '
    end
  end
end

game = Roguelike::Game.new
while game.playing do
  dir = STDIN.getch
  if dir == 'w'
    game.move -1, 0
  elsif dir == 'a'
    game.move 0, -1
  elsif dir == 's'
    game.move 1, 0
  elsif dir == 'd'
    game.move 0, 1
  elsif dir.ord == 13 # return
    # game.touch
  elsif dir.ord == 32 # space
    # game.flag
  elsif dir == 'q'
    exit
  end
end
