def extra_long_factorials n
  out = n
  n -= 1
  until n == 0 do
    out *= n
    n -= 1
  end
  out
end

puts extra_long_factorials 25
