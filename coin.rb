# Your quirky boss collects rare, old coins... They found out you're a programmer
# and asked you to solve something they've been wondering for a long time.
# 
# Write a function that, given:
# 
# an amount of money an array of coin denominations computes the number of ways to
# make the amount of money with coins of the available denominations.
#
# Example: for amount=4(4¢) and denominations= [1,2,3] (1¢, 2¢ and 3¢), your
# program would output 4 — the number of ways to make 4¢ with those denominations:
# - 1¢, 1¢, 1¢, 1¢
# - 1¢, 1¢, 2¢
# - 1¢, 3¢
# - 2¢, 2¢

class Machine
  def self.changings amount, denominations
    changings = Array.new(amount+1, 0)
    changings[0] = 1
    denominations.each do |coin|
      max = coin
      while max <= amount do
        changings[max] += changings[max - coin]
        max += 1
      end
    end
    return changings[amount]
  end
end

{
  [100, [1, 5, 10, 25, 50, 100]] => 292,
  [4, [1, 2, 3]] => 4,
  [3, [1, 2]] => 2,
  [0, [1]] => 1,
  [1, [0]] => 0,
}.each do |input, output|
  result = Machine.changings input[0], input[1]
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
