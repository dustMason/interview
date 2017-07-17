# You're working on a secret team solving coded transmissions. Your team is
# scrambling to decipher a recent message, worried it's a plot to break into a
# major European National Cake Vault. The message has been mostly deciphered, but
# all the words are backwards! Your colleagues have handed off the last step to
# you.
# 
# Write a function reverse_words() that takes a string message and reverses the
# order of the words in-place.
# 
# When writing your function, assume the message contains only letters and spaces,
# and all words are separated by one space.

class Decipher
  def self.reverse_words str
    i = 1
    len = str.size
    word = ''
    insert_index = 0
    str.each_char do |char|
      if char == ' '
        str.insert(insert_index - 1, ' ' + word)
        insert_index -= (word.size) + 1
        word = ''
      else
        word << char
      end
      str = str[1..-1] # fastest way to chop first char
      i += 1
      break if i == len-1
    end
    if !word.empty?
      str = word + str
    end
    str
  end
end


{
  'find you will pain only go you recordings security the into if' => 'if into the security recordings you go only pain will you find',
  '' => '',
  'hello world' => 'world hello',
  'hi' => 'hi'
}.each do |input, output|
  result = Decipher.reverse_words input.dup
  if result == output
    puts "pass"
  else
    puts "FAIL"
    puts "GIVEN      #{input}"
    puts "EXPECTED   #{output}"
    puts "GOT        #{result}"
  end
end
