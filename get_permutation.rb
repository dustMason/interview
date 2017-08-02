def get_permutation(n, i)
  j = k = 0
  
  fact = Array.new(n)
  perm = Array.new(n)

  fact[k] = 1
  while k < n do
    k += 1
    fact[k] = fact[k - 1] * k
  end

  k = 0
  while k < n do
    perm[k] = i / fact[n - 1 - k]
    i = i % fact[n - 1 - k]
    k += 1
  end
    
  k = n - 1
  while k > 0 do
    j = k - 1
    while j >= 0 do
      if !perm[j] || perm[j] <= perm[k]
        perm[k] += 1
      end
      j -= 1
    end
    k -= 1
  end
  
  perm.join
end

puts get_permutation 3, 6
puts get_permutation 10, 3628799
