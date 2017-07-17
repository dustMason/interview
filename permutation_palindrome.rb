# Write an efficient function that checks whether any permutation of an input
# string is a palindrome. You can assume the input string only contains
# lowercase letters.
# 
# Examples:
# 
# "civic" should return true
# "ivicc" should return true
# "civil" should return
# false "livci" should return false
# 
# "But 'ivicc' isn't a palindrome!" If you had this thought, read the question
# again carefully. We're asking if any permutation of the string is a palindrome.
# Spend some extra time ensuring you fully understand the question before
# starting. Jumping in with a flawed understanding of the problem doesn't look
# good in an interview.

require 'set'

class PermutationPalindrome
  def self.check str
    chars = Set.new
    orphans = 0
    str.each_codepoint do |codepoint|
      if chars.include? codepoint
        chars.delete codepoint
        orphans -= 1
      else
        chars.add codepoint
        orphans += 1
      end
    end
    
    if str.size.odd?
      return orphans == 1
    else
      return orphans == 0
    end
  end
end

{
  'civic' => true,
  'ivicc' => true,
  'civil' => false,
  'livci' => false,
  'abba' => true,
  'abbax' => true,
  'abbaxy' => false,
  'abcdef' => false,
  '' => true,
  'a' => true,
  'aa' => true,
}.each do |input, output|
  result = PermutationPalindrome.check input
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
