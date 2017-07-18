# Write a recursive function for generating all permutations of an input string.
# Return them as a set. Don't worry about time or space complexity—if we wanted
# efficiency we'd write an iterative version.
# 
# To start, assume every character in the input string is unique.
# 
# Your function can have loops—it just needs to also be recursive.

class Permuter
  
  def self.permute str
    return build(str.chars).map &:join
  end
  
  def self.build chars=[]
    if chars.size <= 1
      return [chars]
    end
    
    perms = []
    chars.each.with_index do |char, index|
      remaining = chars.reject.with_index { |c, i| i == index }
      build(remaining).each do |perm|
        perms << ([char] + perm)
      end
    end
    
    return perms
  end
end

{
  'abcd' => 'abcd'.chars.permutation(4).map { |p| p.join },
  'octavia' => 'octavia'.chars.permutation(7).map { |p| p.join },
  'jordan' => 'jordan'.chars.permutation(6).map { |p| p.join },
}.each do |input, output|
  result = Permuter.permute input
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
