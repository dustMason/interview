require './tictactoe'

class AI
  def self.move *states
    minmax *states, 0
    return @choice
  end
  
  private
  
  def self.minmax *states, depth
    _winner = winner(*states)
    if _winner && _winner > -1
      # 0 = AI, 1 = opponent. states should always be sorted with AI first
      score = if _winner == 0 then 10 - depth else depth - 10 end
      return score
    elsif _winner == -1
      return 0 # draw
    end
    
    depth += 1
    # we always start on AI's move, so ODD depths always AI's move
    turn = depth % 2 # 0 is AI's move, 1 is opponent
    scores = []
    moves = []
    
    # iterate over every possible move and place a mark there
    available_squares(*states).each do |square|
      future_states = states.map(&:clone)
      future_states[turn][square] = 1 # make the move
      scores << minmax(*future_states, depth)
      moves << square
    end
    
    if turn == 0 # AI turn
      max_score_index = scores.each_with_index.max[1]
      @choice = moves[max_score_index]
      return scores[max_score_index]
    else # opponent turn
      min_score_index = scores.each_with_index.min[1]
      @choice = moves[min_score_index]
      return scores[min_score_index]
    end
  end
  
  def self.winner *states
    moves = states.reduce(0) { |acc, state| acc + state.select { |s| s == 1 }.size }
    if moves == 9
      return -1
    end
    states.index do |state|
      TicTacToe::WIN_POSITIONS.any? { |w| w & state.join.to_i(2) == w }
    end
  end
  
  def self.available_squares *states
    out = (0..8).to_a
    states.each do |state|
      state.each_with_index do |s, i|
        out -= [i] if s == 1
      end
    end
    out
  end
end
