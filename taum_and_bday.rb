# Taum is planning to celebrate the birthday of his friend, Diksha. There are two
# types of gifts that Diksha wants from Taum: one is black and the other is white.
# To make her happy, Taum has to buy  number of black gifts and number of white
# gifts.
# 
# - The cost of each black gift is X units.
# - The cost of every white gift is Y units.
# - The cost of converting each black gift into white gift or vice versa is Z units.
# 
# Help Taum by deducing the minimum amount he needs to spend on Diksha's gifts.

def gift_cost gift_counts, costs
  black_count, white_count = gift_counts
  black_cost, white_cost, conversion_cost = costs
  
  if conversion_cost + [black_cost, white_cost].min >= [black_cost, white_cost].max 
    # just buy what we need, dont do any converting
    return (black_count * black_cost) + (white_count * white_cost)
  else
    # its better to buy all cheapest and convert what we need to the other
    cost = [black_cost, white_cost].min * gift_counts.reduce(&:+)
    if black_cost < white_cost
      cost += white_count * conversion_cost
    else
      cost += black_count * conversion_cost
    end
    return cost
  end
  
end

puts gift_cost [3,6], [9,1,1]
