class String

  def has_unique_chars?
    found_characters = []
    unique = true
    self.codepoints.each do |codepoint|
      if found_characters[codepoint]
        unique = false
        break
      else
        found_characters[codepoint] = true
      end
    end
    unique
  end

end

puts "abcde".has_unique_chars?
puts "aabbcc".has_unique_chars?
puts "jordan".has_unique_chars?
puts "ABCDEFGHabcdefg123456,./l;'[p=-0()@#$&%*".has_unique_chars?
puts "ABCDEFGHabcdefg123456,./l;''[p=-0()@#$&%*".has_unique_chars?
