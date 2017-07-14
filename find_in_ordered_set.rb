# Suppose we had an array of n integers sorted in ascending order. How
# quickly could we check if a given integer is in the array?

class Checker
  def initialize haystack
    @haystack = haystack
  end
  
  # simple binary search
  def check needle, haystack=nil
    haystack ||= @haystack
    middle = (haystack.size - 1) / 2
    if haystack[middle] == needle
      return true
    elsif haystack.empty?
      return false
    elsif haystack[middle] < needle
      return check(needle, haystack[middle+1..-1])
    elsif haystack[middle] > needle
      return check(needle, haystack[0...middle])
    end
    
  end
end

cases = {
  [(1..5).to_a, 9] => false,
  [(1..5).to_a, -1] => false,
  [(1..100).to_a, 500] => false,
}

(1..100).each do |needle|
  cases[[(1..100).to_a, needle]] = true
end

cases.each do |input, output|
  checker = Checker.new input[0]
  result = checker.check input[1]
  if result == output
    print "."
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
