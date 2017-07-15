# Write a function fib() that a takes an integer n and returns the nth
# fibonacci. The Fibonacci series is a numerical series where each item is the
# sum of the two previous items.

# 0,1,1,2,3,5,8,13,21

def fib n
  mem = [0,1]
  if n < 2
    return mem[n]
  end
  i = 1
  until i == n do
    mem = [mem[1], mem[0]+mem[1]]
    i += 1
  end
  mem.last
end

(0..8).to_a.zip([0, 1, 1, 2, 3, 5, 8, 13, 21]).each do |input, output|
  result = fib input
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input}, expected #{output} but got #{result}"
  end
end
