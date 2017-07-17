# I like parentheticals (a lot). "Sometimes (when I nest them (my parentheticals)
# too much (like this (and this))) they get confusing."
# 
# Write a function that, given a sentence like the one above, along with the
# position of an opening parenthesis, finds the corresponding closing parenthesis.
# 
# Example: if the example string above is input with the number 10 (position of
# the first parenthesis), the output should be 79 (position of the last
# parenthesis).

class Parens
  def self.find_matching text, opening_index
    depth = 0
    opening_depth = nil
    out = nil
    text.each_char.with_index do |char, i|
      depth += 1 if char == '('
      if char == ')'
        if opening_depth && depth == opening_depth
          out = i
          break
        end
        depth -= 1
      end
      opening_depth = depth if i == opening_index
    end
    out
  end
end

{
  ['Sometimes (when I nest them (my parentheticals) too much (like this (and this))) they get confusing.', 10] => 79,
  ['(((())))', 0] => 7,
  ['()', 0] => 1,
  ['what', 0] => nil,
  ['', 0] => nil,
  ['(another(test)', 0] => nil,
  [')))', 3] => nil,
  ['(hello(world))', 6] => 12,
}.each do |input, output|
  result = Parens.find_matching input[0], input[1]
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
