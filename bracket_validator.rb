# You're working with an intern that keeps coming to you with JavaScript code that
# won't run because the braces, brackets, and parentheses are off. To save you
# both some time, you decide to write a braces/brackets/parentheses validator.
# Let's say:
# 
# '(', '{', '[' are called "openers." ')', '}', ']' are called "closers." Write an
# efficient function that tells us whether or not an input string's openers and
# closers are properly nested.
# 
# Examples:
# 
# "{ [ ] ( ) }" should return true
# "{ [ ( ] ) }" should return false "{ [ }"
# should return false

class Validator
  def self.validate code
    openers = ['(', '{', '[']
    closers = [')', '}', ']']
    opens = []
    depth = 0
    code.each_char.with_index do |char|
      o = openers.find_index char
      if o
        opens << o
        depth += 1
      else
        c = closers.find_index char
        if c
          if c == opens.pop
            depth -= 1
          else
            return false
          end
        end
      end
    end
    return depth == 0
  end
end

{
  '{ [ ] ( ) }' => true,
  '{ [ ( ] ) }' => false,
  '{ [ }' => false,
  '' => true,
  ')))' => false,
  '((' => false,
}.each do |input, output|
  result = Validator.validate input
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
