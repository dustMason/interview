class WordCloud
  def self.build str
    chars = []
    cloud = {}
    lowercase_next = false
    str.each_codepoint.each_with_index do |cp, i|
      if is_alphanumeric cp
        if (lowercase_next || i == 0) && is(cp, :capital)
          cp += 32 
          lowercase_next = false
        end
        chars << cp
      elsif !chars.empty?
        word = chars.pack("U*")
        cloud[word] ||= 0
        cloud[word] += 1
        chars = []
      end
      lowercase_next = is(cp, :period)
    end
    cloud
  end
  
  private
  
  def self.is char, type
    { digit: (48..57),
      capital: (65..90),
      lowercase: (97..122),
      period: (46..46),
      hyphen: (45..45)
    }[type].include? char
  end
  
  def self.is_alphanumeric c
    is(c, :digit) || is(c, :capital) || is(c, :lowercase) || is(c, :hyphen)
  end
end

{
  "After beating the eggs, Dana read the next step:" => {
    'after' => 1, 'beating' => 1, 'the' => 2, 'eggs' => 1, 'Dana' => 1,
    'read' => 1, 'next' => 1, 'step' => 1
  },
  "Add milk and eggs, then add flour and sugar." => {
    'add'=>2, 'milk'=>1, 'and'=>2, 'eggs'=>1, 'then'=>1, 'flour'=>1, 'sugar' => 1
  },
  "Add milk-eggs, then add flour-sugar." => {
    'add'=>2, 'milk-eggs'=>1, 'then'=>1, 'flour-sugar'=>1
  }
}.each do |input, output|
  result = WordCloud.build input
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
