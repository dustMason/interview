class Merger

  def self.merge left=[], right=[], acc=[]
    return acc if left.empty? && right.empty?
    if left.first && (right.empty? || left.first <= right.first)
      merge left[1..-1], right, acc<<left.first
    else
      merge left, right[1..-1], acc<<right.first
    end
  end

end

left = [1,3,5,7,9]
right = [0,2,4,6,8,8,8,8,100,2000]
puts Merger.merge(left, right).inspect

right = [1,3,5,7,9]
left = [0,2,4,6,8,8,8,8,100,2000]
puts Merger.merge(left, right).inspect

left = [5,6,7,8,9]
right = [1,2,3,4,4,4,5]
puts Merger.merge(left, right).inspect

right = [5,6,7,8,9]
left = [1,2,3,4,4,4,5]
puts Merger.merge(left, right).inspect
