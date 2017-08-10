class TicTacToe
  WIN_POSITIONS = [
    0b111000000, 0b000111000, 0b000000111, # rows
    0b100100100, 0b010010010, 0b001001001, # columns
    0b100010001, 0b001010100 # diagonals
  ]
  
  attr_reader :playing, :state
  
  def initialize *players
    @players = players
    @turn = 0
    @turn_count = 0
    @state = players.map { Array.new(9,0) }
    @marks = ['X','O']
    @playing = true
    display
  end
  
  def mark cursor
    puts "trying to go #{cursor}"
    if !marked? cursor
      @turn_count += 1
      @state[@turn][cursor] = 1
      @turn = (@turn + 1) % 2
      display
      if _winner = winner.first
        puts "#{_winner} won!"
        @playing = false
      elsif @turn_count == 9
        puts "It's a draw"
        @playing = false
      end
    else
      puts "You can't go there"
    end
  end
  
  private
  
  def display
    system 'clear'
    board = Array.new(9).map { " " }
    @state.each_with_index do |state, player_index|
      state.each_with_index do |c, i|
        board[i] = @marks[player_index] if c == 1
      end
    end
    puts board.each_slice(3).map { |r| r.join ' | ' }.join "\n--+---+--\n"
    puts "\nIt's #{@players[@turn]}'s turn (#{@marks[@turn]})"
  end
  
  def winner
    @players.select.with_index do |player, i|
      state = @state[i].join.to_i(2) # convert to int as binary
      WIN_POSITIONS.any? { |w| w & state == w }
    end
  end
  
  def marked? cursor
    @state.any? { |s| s[cursor] == 1 }
  end
end
