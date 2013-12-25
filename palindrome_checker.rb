def is_palindrome? string
  return true if string.empty?
  return false if string[0] != string[-1]
  is_palindrome? string[1..-2]
end

puts is_palindrome? "not at all"
puts is_palindrome? "racecar"
