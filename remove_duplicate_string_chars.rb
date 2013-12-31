class String

  def remove_duplicates
    found_characters = []
    self.chars.map do |char|
      next if found_characters[char.ord]
      found_characters[char.ord] = true
      char
    end.join
  end

end

puts "aAabBbcCcAa@2".remove_duplicates
