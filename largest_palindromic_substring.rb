# max length of str is 1000

# iterate over the string, checking to see if each character is at the center of
# a palindrome and what the length of that palindrome is. we do this check in an
# inner loop, giving this solution an O(n^2) time complexity. space complexity is
# fixed.
def longest_palindrome str
  _start = _end = 0
  str.each_char.with_index do |char, i|
    len1 = expand_from_center str, i, i
    len2 = expand_from_center str, i, i+1
    len = [len1, len2].max
    if len > _end - _start
      _start = i - (len-1) / 2
      _end = i + len/2
    end
  end
  str[_start.._end]
end

# walk outward from starting positions until we aren't looking at a palindrome.
# (this includes the starting condition, given different values for left and right)
def expand_from_center str, left, right
  while left >= 0 && right < str.size && str[left] == str[right] do
    left -= 1
    right += 1
  end
  right - left - 1
end


{
  "babad" => "aba",
  "cbbd" => "bb",
  "asdfkjhsadkfjhasdfracecarbfb1b3h4" => "racecar",
  "pipashbfnsjad" => "pip",
  "nfhbdcjndcbob" => "bob",
  "" => "",
  "f" => "f",
  "abcdef" => "f"
}.each do |input, output|
  result = longest_palindrome input
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
