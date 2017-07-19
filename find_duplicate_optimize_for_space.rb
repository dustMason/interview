# Find a duplicate, Space Edition™. We have an array of integers, where:

# The integers are in the range 1..n
# The array has a length of n+1

# It follows that our array has at least one integer which appears at least
# twice. But it may have several duplicates, and each duplicate may appear
# more than twice.
# 
# Write a function which finds an integer that appears more than once in our
# array. (If there are multiple duplicates, you only need to find one of them.)
# 
# We're going to run this function on our new, super-hip Macbook Pro With Retina
# Display™. Thing is, the damn thing came with the RAM soldered right to the
# motherboard, so we can't upgrade our RAM. So we need to optimize for space!

class DoubleFinder
  def self.find numbers=[]
    if numbers.empty?
      return nil
    end
    
    sum = 0
    
    # start the scout at the end, then run through the whole graph to make sure
    # that if there is a loop in there, we end up in it. we also check the sum
    # along the way to handle an edge case.
    scout = numbers.size
    (numbers.size-1).times do |i|
      scout = numbers[scout - 1]
      sum += numbers[i]
    end
    
    # handle an edge case: if there aren't any duplicates
    sum += numbers[numbers.size-1]
    unexpected_sum = (numbers.size * (numbers.size+1)) / 2
    if sum == unexpected_sum
      return nil
    end

    # now that we're in the loop for sure, we can measure how long it is by
    # stepping ahead until we end up where we started.
    steps = 1
    _scout = numbers[scout - 1]
    until _scout == scout do
      _scout = numbers[_scout - 1]
      steps += 1
    end

    # now we can use a similar technique to linked_list_cycles to find exactly
    # where the cycle in the graph begins. hare starts at the end of the loop,
    # tortoise at the beginning. when they end up at the same node, we know that
    # is a duplicate because it has two incoming pointers.
    hare = tortoise = numbers.size
    steps.times { hare = numbers[hare - 1] }
    until hare == tortoise do
      hare = numbers[hare - 1]
      tortoise = numbers[tortoise - 1]
    end

    return hare
  end
end

{
  [1, 1, 1, 1, 1, 2, 3, 4] => 1,
  [4, 5, 5, 3, 2, 1] => 5,
  [5, 4, 3, 2, 1, 1] => 1,
  [1, 2, 2, 3, 4] => 2,
  [1, 2, 3, 3, 4] => 3,
  [1, 2, 3, 4, 4] => 4,
  [1, 2, 3, 4, 7, 4, 4] => 4,
  [4, 1, 2, 3, 4, 7, 4] => 4,
  [] => nil,
  [1] => nil,
  [1, 2, 3, 4, 5, 6] => nil,
  [1, 1, 2, 2, 2, 3, 3, 4, 5, 6] => 1,
  [2, 2, 2, 3, 3, 4, 5, 6] => 2,
  [6, 4, 2, 1, 3, 5, 4] => 4,
  [5, 4, 3, 2, 1, 1].shuffle => 1,
  ((1..100).to_a + [4]).shuffle => 4,
}.each do |input, output|
  result = DoubleFinder.find input
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
