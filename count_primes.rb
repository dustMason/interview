def count_primes(n)
  if n < 3
    return 0
  end
  i = 2
  primes = Array.new(n, true)
  primes[0] = primes[1] = false
  while i**2 < n do
    if primes[i]
      j = i**2
      while j < n do
        primes[j] = false
        j += i
      end
    end
    i += 1
  end
  primes.select{|_|_}.size
end

{
  0 => 0,
  2 => 0,
  3 => 1,
  4 => 2
}.each do |input, output|
  result = count_primes input
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
