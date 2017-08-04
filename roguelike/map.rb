module Roguelike
  class Map
    
    attr_reader :start, :stairs
    
    def initialize width, height
      @width = width
      @height = height
      @revealed = {}
      generate!
    end
    
    def each_tile &block
      @board.each_with_index do |row, y|
        row.each_with_index do |tile, x|
          block.call y, x, tile, @revealed[[y, x]], (x == @width-1)
        end
      end
    end
    
    def random_location
      @room_to_loc[@room_to_loc.keys.sample].sample
    end
    
    def enter y, x
      if @board[y][x] != WALL
        neighbors = direct_neighbor_coords y, x
        until neighbors.empty? do
          ny, nx = neighbors.pop
          if !@revealed[[ny, nx]] && ![WALL, DOOR].include?(@board[ny][nx])
            neighbors += direct_neighbor_coords(ny, nx)
          end
          @revealed[[ny, nx]] = true
        end
        true
      else
        false
      end
    end
    
    private
    
    # Cellular automata are a fun way to create organic feeling constructions.
    # This method builds up a dungeon map by applying a set of rules to control
    # how a set of random seeds grow into rooms which are connected by doors.
    def generate!
      @board = Array.new(@height).map { Array.new(@width) }
      @loc_to_room = {}
      @room_to_loc = {}
      
      # Place room seeds randomly.
      room = 100
      each_tile do |y, x, tile|
        if rand(0..100) == 0 
          @loc_to_room[[y, x]] = room
          @board[y][x] = room
          room += 1
        else
          @board[y][x] = WALL
        end
      end
      
      # Iteratively grow each room outward from the seed. The rooms are very
      # likely to overlap with nearby rooms, which is desired.
      8.times do
        keys = @loc_to_room.keys
        keys.each do |key|
          y, x = key
          val = @loc_to_room[key]
          neighbor_coords(y, x).each do |y, x|
            @board[y][x] = val
            @loc_to_room[[y, x]] = val
          end
        end
      end
        
      # Surround each room and the map perimeter with walls.
      each_tile do |y, x, tile|
        if is_edge?(y, x)
          @board[y][x] = WALL
        elsif direct_neighbor_coords(y, x).any? { |y, x| ![tile, WALL].include? @board[y][x] }
          @board[y][x] = WALL
        end
      end
      
      # Add 2 random door sections to each room.
      @loc_to_room.each do |coord, room|
        @room_to_loc[room] ||= []
        @room_to_loc[room] << coord.to_a
      end
      @room_to_loc.each do |room_id, coords|
        walls = coords.select { |y, x| @board[y][x] == WALL && !is_edge?(y, x) }
        new_doors = walls.sample(2)
        new_doors.each { |y, x| @board[y][x] = DOOR }
        walls.each do |y, x|
          direct_neighbor_coords(y, x).each do |ny, nx|
            if new_doors.include?([ny, nx])
              @board[y][x] = DOOR
            end
          end
          @loc_to_room.delete [y, x]
          @room_to_loc[room_id] -= [[y, x]]
        end
      end
      
      # Place START and STAIRS locations randomly among room locations.
      @room_to_loc.keys.sample(2).each_with_index do |room_id, i|
        y, x = @room_to_loc[room_id].sample 
        if i == 0 
          @board[y][x] = START
          @start = [y, x]
        else
          @board[y][x] = STAIRS
          @stairs = [y, x]
        end
      end
      
      # Validate that this map is solvable. If not, try again with a new map.
      if !path_exists? @start, @stairs
        puts "generated a bad map, trying again."
        generate!
      end
    end
    
    def path_exists? from, to
      neighbors = direct_neighbor_coords *from
      seen = {}
      until neighbors.empty? do
        y, x = neighbors.pop
        if @board[y][x] != WALL && !seen[[y, x]]
          if [y, x] == to
            return true
          end
          neighbors += direct_neighbor_coords(y, x)
        end
        seen[[y, x]] = true
      end
      return false
    end
    
    def is_edge? y, x
      y == 0 || y == @height-1 || x == 0 || x == @width-1
    end
    
    def neighbor_coords y, x
      NEIGHBORS.map { |dy, dx| [y+dy, x+dx] }.select { |y, x| valid_tile? y, x }
    end
    
    def direct_neighbor_coords y, x
      # The first 4 NEIGHBORS are the cardinal directions N-S-E-W
      NEIGHBORS[0..3].map { |dy, dx| [y+dy, x+dx] }.select { |y, x| valid_tile? y, x }
    end
    
    def valid_tile? y, x
      !!(@board[y] || [])[x]
    end
  end
end
