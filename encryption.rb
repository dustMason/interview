# An English text needs to be encrypted using the following encryption scheme.
# First, the spaces are removed from the text. Let L be the length of this text. 
# 
# For example, the sentence `if man was meant to stay on the ground god would have
# given us roots` after removing spaces is 54 characters long, so it is written in
# the form of a grid with 7 rows and 8 columns.
# 
# ```
# ifmanwas  
# meanttos          
# tayonthe  
# groundgo  
# dwouldha  
# vegivenu  
# sroots
# ```
# 
# The encoded message is obtained by displaying the characters in a column,
# inserting a space, and then displaying the next column and inserting a space,
# and so on. For example, the encoded message for the above rectangle is:
# 
# `imtgdvs fearwer mayoogo anouuio ntnnlvt wttddes aohghn sseoau`
# 
# You will be given a message in English with no spaces between the words. The
# maximum message length can be  characters. Print the encoded message.

def encode text
  width = Math.sqrt(text.size).ceil
  word_length = Math.sqrt(text.size).round
  
  chars = text.chars
  out = ""
  width.times do |i|
    word_length.times do |j|
      ind = (j * width) + i
      out << chars[ind] if chars[ind]
    end
    out << " "
  end
  out
end
