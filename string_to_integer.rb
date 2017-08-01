# concerns:

# Q: overflow? string could be a number too big for MAXINT.
# A: ruby will use Bignum under the hood, protecting against this. It switches at 62-bits
# (one bit for twos-complement encoding of pos/neg and one bit for Fixnum/Bignum flag)

# Q: whitespace?
# A: String#strip trims leading and trailing whitespace from input

# Q: plus / minus sign?
# A: function looks for the (optional) presence of a minus sign and applies a -1 mult

# Q: non-numerical input?
# A: starting at the left position, we make sure we have some valid digits. if not,
# the function returns immediately. we consider only valid digits and symbols.

def atoi input
  out = 0
  pos = 1
    
  digits = []
  input.strip.each_codepoint.with_index do |codepoint, i|
    if !is_valid?(codepoint) || (i > 0 && !is_numeric?(codepoint))
      break
    else
      digits << codepoint
    end
  end
  
  sign = digits.shift if is_valid_symbol?(digits[0])
  sign = if sign && sign.ord == 45 then -1 else 1 end
    
  i = digits.size-1
  until i == -1 do
    out += (digits[i] - 48) * pos # UTF/ASCII: 0-9 is 48-57
    pos *= 10
    i -= 1
  end
  
  out * sign
end

def is_valid? codepoint
  is_valid_symbol?(codepoint) || is_numeric?(codepoint)
end

def is_numeric? codepoint
  (48..57).include? codepoint
end

def is_valid_symbol? codepoint
  [43, 45].include? codepoint
end

{
  "0" => 0,
  "1" => 1,
  "400" => 400,
  "+93748" => 93748,
  "-93748" => -93748,
  "45ddd" => 45,
  "abc123" => 0,
  "23+45" => 23,
  "123" => 123,
  "12345623987641298347612983746294857629348751234562398764129834761298374629485762934875" => 12345623987641298347612983746294857629348751234562398764129834761298374629485762934875
}.each do |input, output|
  result = atoi input.to_s
  if result == output
    puts "pass"
  else
    puts "fail"
    puts "given #{input} expected #{output} got #{result}"
  end
end
