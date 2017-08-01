class Solver
  def initialize rooms
    @rooms = rooms
    return rooms if rooms.empty?
    @h = rooms.size
    @w = rooms[0].size
    find_gates!
  end
  
  def solve
    return @rooms if @rooms.empty?
    @gates.each do |row, col|
      @explored = {[row, col] => true}
      to_explore = neighbors([row, col], 1)
      until to_explore.empty? do
        _next = to_explore.shift
        dist = _next[2]
        if @rooms[_next[0]][_next[1]] > 0 && dist < @rooms[_next[0]][_next[1]]
          @rooms[_next[0]][_next[1]] = dist
          to_explore.push(*neighbors(_next, dist+1))
        end
        @explored[[_next[0], _next[1]]] = true
      end
    end
    @rooms
  end
  
  private
  
  def find_gates!
    @gates = []
    @rooms.each_with_index do |row, y|
      row.each_with_index do |col, x|
        if col == 0
          @gates << [y, x]
        end
      end
    end
  end
  
  def neighbors start, dist
    out = []
    if start[0] > 0 && explorable?([start[0]-1, start[1]]) then out << [start[0]-1, start[1], dist] end
    if start[0] < @h-1 && explorable?([start[0]+1, start[1]]) then out << [start[0]+1, start[1], dist] end
    if start[1] > 0 && explorable?([start[0], start[1]-1]) then out << [start[0], start[1]-1, dist] end
    if start[1] < @w-1 && explorable?([start[0], start[1]+1]) then out << [start[0], start[1]+1, dist] end
    out
  end
  
  def explorable? room
    !@explored.has_key?(room) && @rooms[room[0]][room[1]] > 0
  end
end

def walls_and_gates rooms
  solver = Solver.new rooms
  solver.solve
end

# --- Test Harness ---

def print_rooms rooms
  rooms.each do |row|
    row.each do |col|
      char = if col == -1 then "♜" elsif col == 0 then "_" elsif col == INF then " " else col end
      print "#{char} "
    end
    print "\n"
  end
end

INF = Float::INFINITY

{
  [[INF, -1, 0 , INF], [INF, INF, INF, -1], [INF, -1, INF, -1], [0, -1, INF, INF]] =>
  [[3, -1, 0, 1], [2, 2, 1, -1], [1, -1, 2, -1], [0, -1, 3, 4]],
  
  [[-1,0,INF,INF,0,0,INF,INF,-1,0,0,-1,-1,INF,-1,-1,INF,INF,INF,0,0,-1,INF,-1,-1,-1,0,INF,0,0,0,-1,INF,0,0,INF,-1,-1,0,0,-1,0,INF,INF,-1,INF],[0,-1,0,-1,0,0,0,-1,-1,0,-1,INF,INF,-1,INF,-1,INF,-1,-1,INF,0,-1,INF,0,INF,0,-1,INF,0,-1,-1,INF,0,INF,0,INF,-1,INF,INF,INF,-1,0,-1,INF,0,INF],[INF,-1,-1,INF,0,0,0,INF,-1,0,-1,-1,INF,INF,INF,INF,-1,INF,0,0,INF,0,-1,0,0,INF,INF,0,0,INF,-1,-1,0,INF,0,INF,-1,-1,INF,INF,0,-1,INF,-1,-1,-1],[INF,-1,-1,INF,0,-1,-1,-1,-1,-1,0,-1,-1,INF,0,-1,-1,-1,INF,INF,-1,INF,-1,-1,-1,0,-1,-1,0,-1,0,-1,INF,INF,INF,INF,INF,0,0,INF,INF,INF,INF,0,INF,INF],[INF,INF,INF,-1,-1,INF,INF,-1,0,INF,-1,0,0,INF,INF,0,INF,-1,-1,INF,0,0,0,-1,INF,0,INF,-1,INF,0,0,-1,0,INF,-1,0,-1,-1,INF,-1,0,0,-1,-1,-1,-1],[-1,-1,INF,INF,0,INF,0,0,INF,INF,0,-1,0,INF,-1,INF,INF,0,INF,INF,-1,0,0,INF,-1,-1,0,-1,INF,0,0,0,0,0,INF,0,0,-1,0,0,-1,0,-1,0,0,-1]] =>
  [[-1,0,1,1,0,0,1,2,-1,0,0,-1,-1,INF,-1,-1,3,2,1,0,0,-1,2,-1,-1,-1,0,1,0,0,0,-1,1,0,0,1,-1,-1,0,0,-1,0,1,2,-1,2],[0,-1,0,-1,0,0,0,-1,-1,0,-1,5,4,-1,2,-1,4,-1,-1,1,0,-1,1,0,1,0,-1,1,0,-1,-1,1,0,1,0,1,-1,2,1,1,-1,0,-1,1,0,1],[1,-1,-1,1,0,0,0,1,-1,0,-1,-1,3,2,1,2,-1,1,0,0,1,0,-1,0,0,1,1,0,0,1,-1,-1,0,1,0,1,-1,-1,1,1,0,-1,2,-1,-1,-1],[2,-1,-1,1,0,-1,-1,-1,-1,-1,0,-1,-1,1,0,-1,-1,-1,1,1,-1,1,-1,-1,-1,0,-1,-1,0,-1,0,-1,1,2,1,1,1,0,0,1,1,1,1,0,1,2],[3,4,3,-1,-1,2,1,-1,0,1,-1,0,0,1,1,0,1,-1,-1,1,0,0,0,-1,1,0,1,-1,1,0,0,-1,0,1,-1,0,-1,-1,1,-1,0,0,-1,-1,-1,-1],[-1,-1,2,1,0,1,0,0,1,1,0,-1,0,1,-1,1,1,0,1,2,-1,0,0,1,-1,-1,0,-1,1,0,0,0,0,0,1,0,0,-1,0,0,-1,0,-1,0,0,-1]]
  
}.each do |input, output|
  result = walls_and_gates input.clone
  if output == result
    puts "pass"
  else
    puts "fail"
    puts "---"*10
    puts "expected"
    print_rooms output
    puts "---"*10
    puts "got"
    print_rooms result
  end
end
