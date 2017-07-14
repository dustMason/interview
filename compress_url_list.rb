# I'm making a search engine called MillionGazillion™.

# I wrote a crawler that visits web pages, stores a few keywords in a database,
# and follows links to other web pages. I noticed that my crawler was wasting a
# lot of time visiting the same pages over and over, so I made a set, visited,
# where I'm storing URLs I've already visited. Now the crawler only visits a URL
# if it hasn't already been visited.
# 
# Thing is, the crawler is running on my old desktop computer in my parents'
# basement (where I totally don't live anymore), and it keeps running out of
# memory because visited is getting so huge.
# 
# How can I trim down the amount of space taken up by visited?

class TrieNode
  attr_reader :children
  
  def initialize
    @children = {} # hash map of letters
  end
  
  def has? char
    @children.has_key? char
  end
  
  def store str
    node = self
    # walk the tree, following each letter until we hit a dead end
    str.each_char.each_with_index do |char, i|
      if node.has? char
        node = node.children[char]
      else
        # then extend it to contain the remaining letters
        node.extend_with str[i..-1]
        break
      end
    end
  end
  
  def extend_with str
    _children = @children
    str.each_char do |char|
      _children[char] = TrieNode.new
      _children = _children[char].children
    end
  end
  
  def to_s
    children.map do |k, v|
      "#{k}|#{v.to_s}"
    end.join " _ "
  end
end

cache = TrieNode.new
%w{www.google.com www.apple.com/mac www.apple.com/iphone www.apple.com/macos}.each { |word| cache.store word }
puts cache.to_s
