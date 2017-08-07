require 'io/console'

require './ai'
require './tictactoe'

game = TicTacToe.new "Jordan", "AI"
while game.playing do
  cmd = STDIN.getch
  positions = %w{q w e a s d z x c} # key grid
  if cursor = positions.index(cmd)
    game.mark cursor
    game.mark AI.move(*game.state)
  elsif cmd == 'p'
    exit
  end
end
