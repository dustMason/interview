# https://www.interviewcake.com/question/ruby/stock-price

# Suppose we could access yesterday's stock prices as an array, where:
# 
# The indices are the time in minutes past trade opening time, which was 9:30am local time.
# The values are the price in dollars of Apple stock at that time.
# So if the stock cost $500 at 10:30am, stock_prices_yesterday[60] = 500.
# 
# Write an efficient function that takes stock_prices_yesterday and returns the
# best profit I could have made from 1 purchase and 1 sale of 1 Apple stock yesterday.

class Trader
  def initialize prices
    raise 'prices.size must be > 1' unless prices.size > 1
    @prices = prices
  end
  
  def get_max_profit
    lowest_price = @prices[0]
    best_trade_val = @prices[1] - @prices[0]
    @prices.each_with_index do |price, i|
      next if i == 0 # we started with first two
      current_trade = price - lowest_price
      best_trade_val = [best_trade_val, current_trade].max
      lowest_price = [lowest_price, price].min
    end
    best_trade_val
  end
end

{
  [10, 7, 5, 8, 11, 9] => 6,
  [6, 16, 1, 14, 5, 2, 0] => 13,
  [6, 16, 1, 14, 5, 2] => 13,
  [6, 16, 1, 2, 3, 4, 5, 6, 14, 5] => 13,
  [1, 3, 2, 10] => 9,
  [3, 2, 3, 1, 5, 3, 10] => 9,
  [0, 0] => 0,
  [1000, 1000, 1000, 999, 998] => 0,
  [1000, 999, 998] => -1,
  [1000, 900, 998] => 98,
  [1000, 900, 800] => -100,
}.each do |input, output|
  t = Trader.new input
  result = t.get_max_profit
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
  
