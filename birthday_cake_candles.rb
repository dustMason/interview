def birthdayCakeCandles(n, ar)
  candles = 1
  ar.sort.reverse.each_cons(2) do |x, y|
    if x == y
      candles += 1
    else
      break
    end
  end
  candles
end

test = [99999] * 10000
puts birthdayCakeCandles(10000, test)
