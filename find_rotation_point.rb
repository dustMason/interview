# I want to learn some big words so people think I'm smart. I opened up a
# dictionary to a page in the middle and started flipping through, looking for
# words I didn't know. I put each word I didn't know at increasing indices in a
# huge array I created in memory. When I reached the end of the dictionary, I
# started from the beginning and did the same thing until I reached the page I
# started at.
# 
# Now I have an array of words that are mostly alphabetical, except they start
# somewhere in the middle of the alphabet, reach the end, and then start from the
# beginning of the alphabet. In other words, this is an alphabetically ordered
# array that has been "rotated." For example:
# 
#   words = [ 'ptolemaic', 'retrograde', 'supplant', 'undulate', 'xenoepist',
#   'asymptote', # <-- rotates here! 'babka', 'banoffee', 'engender', 'karpatka',
#   'othellolagkage', ]
# 
# Write a function for finding the index of the "rotation point," which is where I
# started working from the beginning of the dictionary. This array is huge (there
# are lots of words I don't know) so we want to be efficient here.

class Dictionary
  def initialize words=[]
    @words = words
  end
  
  def find_rotation_point_recursive words=nil, min=nil
    words ||= @words
    middle = (words.size - 1) / 2
    min ||= 0
    if words.size == 1
      return (if min >= 0 then min else 0 end)
    elsif words[middle] > words.last
      return find_rotation_point_recursive words[middle+1..-1], min+middle+1
    else
      return find_rotation_point_recursive words[0..middle], min
    end
  end
  
  def find_rotation_point
    l = 0
    r = @words.size - 1
    if @words[l] < @words[r]
      # short-circuit if words aren't rotated
      return 0
    end
    until r == l do
      middle = (l + r) / 2
      if r - l == 1
        # pick one of the last two
        l = (if @words[l] < @words[r] then l else r end)
        break
      elsif @words[l] < @words[middle]
        l = middle + 1
      else
        r = middle
      end
    end
    return l
  end
end

{
  %w{ptolemaic retrograde supplant undulate xenoepist asymptote babka banoffee engender karpatka othellolagkage} => 5,
  %w{h i j k l m n o a b c d e f} => 8,
  %w{g h i j k l m n o a b c d e f} => 9,
  %w{o a b c d e f h i j k l m n} => 1,
  %w{a b c d e f g} => 0,
}.each do |input, output|
  dict = Dictionary.new input
  result1 = dict.find_rotation_point
  result2 = dict.find_rotation_point_recursive
  [result1, result2].each do |result|
    if result == output
      print "."
    else
      puts "FAIL given #{input}, expected #{output} but got #{result}"
    end
  end
end
