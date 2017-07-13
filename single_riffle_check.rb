# I figured out how to get rich: online poker. I suspect the online poker game I'm
# playing shuffles cards by doing a single "riffle."
# 
# To prove this, let's write a function to tell us if a full deck of cards
# shuffled_deck is a single riffle of two other halves half1 and half2.
# 
# We'll represent a stack of cards as an array of integers in the range 1..52
# (since there are 52 distinct cards in a deck).
# 
# Why do I care? A single riffle is not a completely random shuffle. If I'm right,
# I can make more informed bets and get rich and finally prove to my ex that I am
# not a "loser with an unhealthy cake obsession" (even though it's too late now
# because she let me go and she's never getting me back).

class Riffler
  def self.check_perfect_riffle shuffled_deck=[], half1=[], half2=[]
    check_args shuffled_deck, half1, half2
    
    if half1.last == shuffled_deck.last
      halves = [half2, half1]
    elsif half2.last == shuffled_deck.last
      halves = [half1, half2]
    else
      return false
    end
    
    i = 51
    while i >= 0 do
      card = halves[i % 2][i/2]
      if card != shuffled_deck[i]
        return false
      end
      i -= 1
    end
    true
  end
  
  def self.check_riffle shuffled_deck=[], half1=[], half2=[]
    check_args shuffled_deck, half1, half2
    left = 25
    right = 25
    while left + right >= 0 do
      i = left + right + 1
      if shuffled_deck[i] == half1[left]
        left -= 1
      elsif shuffled_deck[i] == half2[right]
        right -= 1
      else
        return false
      end
    end
    return true
  end
  
  private
  
  def self.check_args shuffled_deck, half1, half2
    raise "We ain't playing with a full deck" unless shuffled_deck.size == 52
    raise "Each half must contain 26 cards" unless [half1.size, half2.size] == [26, 26]
  end
end

{
  [(1..26).to_a.zip((27..52).to_a).flatten, (1..26).to_a, (27..52).to_a] => true, # perfect riff
  [(1..52).to_a, (1..26).to_a, (27..52).to_a] => true, # cut the deck
  [(1..52).to_a.shuffle, (1..26).to_a, (27..52).to_a] => false # 'true' shuffle
}.each do |input, output|
  result = Riffler.check_riffle input[0], input[1], input[2]
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "given     #{input}"
    puts "expected  #{output}"
    puts "got       #{result}"
  end
end

{
  [(1..26).to_a.zip((27..52).to_a).flatten, (1..26).to_a, (27..52).to_a] => true, # perfect riff
  [(1..52).to_a, (1..26).to_a, (27..52).to_a] => false, # cut the deck
  [(1..52).to_a.shuffle, (1..26).to_a, (27..52).to_a] => false # 'true' shuffle
}.each do |input, output|
  result = Riffler.check_perfect_riffle input[0], input[1], input[2]
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "given     #{input}"
    puts "expected  #{output}"
    puts "got       #{result}"
  end
end
