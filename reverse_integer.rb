# i couldn't figure this one out without converting to a string.
# this solution is from https://gist.github.com/eneagoe/7890670

def reverse_integer int
  r = 0
  r, int = (r*10 + int % 10), int / 10 while int != 0
  r
end

puts reverse_integer 12345
