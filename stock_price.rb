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
    @prices = prices
    @best_trade_val = 0
    @current_trade = []
  end
  
  def get_max_profit
    last_price = Float::INFINITY
    
    @prices.each_with_index do |price, i|
      if price < last_price
        if open_trade?
          check_trade
          @current_trade = []
        end
      end
      
      if price > last_price
        if open_trade?
          @current_trade[1] = price
        else
          @current_trade = [last_price, price]
        end
        check_trade
      end
          
      last_price = price
    end
    
    @best_trade_val
  end
  
  def check_trade
    current_trade_val = @current_trade[1] - @current_trade[0]
    if current_trade_val > @best_trade_val
      @best_trade_val = current_trade_val
    end
  end
  
  def open_trade?
    !@current_trade.empty?
  end
end

{
  [10, 7, 5, 8, 11, 9] => 6,
  [6, 16, 1, 14, 5, 2, 0] => 13,
  [6, 16, 1, 14, 5, 2] => 13,
  [1, 3, 2, 10] => 8,
  [0, 0] => 0,
  [] => 0,
  [1000, 999, 998] => 0
}.each do |input, output|
  t = Trader.new input
  result = t.get_max_profit
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
  
