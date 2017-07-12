class WordCloud
  def self.build str
    chars = []
    cloud = {}
    lowercase_next = false
    str.each_codepoint.each_with_index do |cp, i|
      if is_alphanumeric cp
        if (lowercase_next || i == 0) && is_cap(cp)
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
      lowercase_next = is_period cp
    end
    cloud
  end
  
  private
  
  def self.is_alphanumeric c
    (c >= 47 && c <= 57) || is_cap(c) || (c >= 97 && c <= 122) || (c == 45)
  end

  def self.is_cap c
    c >= 65 && c <= 90
  end

  def self.is_period c
    c == 46
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
