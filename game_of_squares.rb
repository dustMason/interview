# 0 lose
# 1 win *
# 2 lose (1x)
# 3 win (1x)
# 4 win *
# 5 lose (1x, 4x)
# 6 win (1√, 4√)
# 7 lose (1x, 4x)
# 8 win (1√, 4x)
# 9 win *
# 10 lose (1x, 4x, 9x)

MEMO = {}

def optimal_move state
  if MEMO.has_key? state
    return MEMO[state]
  else
    if Math.sqrt(state) % 1 == 0 # its a perfect square
      MEMO[state] = state
      return state 
    else
      (1..Math.sqrt(state)).each do |n|
        if optimal_move(state - (n*n)) == -1
          MEMO[state-n*n] = -1
          return n*n
        end
      end
      MEMO[state] = -1
      return -1
    end
  end
end

[2, 5, 7, 10, 12, 15, 17, 20, 22, 34, 39, 44, 52].each do |loser|
  if optimal_move(loser) == -1
    print "pass "
  else
    print "fail (#{loser}) "
  end
end

[1, 3, 4, 6, 8, 9, 11, 13, 14, 16, 18, 19, 21, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 35, 36, 37, 38, 40, 41, 42, 43, 45].each do |winner|
  if optimal_move(winner) == -1
    print "fail (#{winner}) "
  else
    print "pass "
  end
end
