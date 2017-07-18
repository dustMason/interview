# Write a function for doing an in-place ↴ shuffle of an array. The shuffle must
# be "uniform," meaning each item in the original array must have the same
# probability of ending up in each spot in the final array.
# 
# Assume that you have a function get_random(floor, ceiling) for getting a random
# integer that is >= floor and <= ceiling.


class Shuffler
  def self.shuffle arr
    # Number of possible arrangements is arr.size! (factorial). Make sure we
    # allow exactly that many chances to rearrange the items.
    possibilities = (1..arr.size).reduce(1, :*)
    possibilities.times do |i|
      j = get_random(0, arr.size-1)
      arr[i], arr[j] = arr[j], arr[i]
    end
    arr.compact
  end
  
  private
  
  def self.get_random(floor, ceiling)
    rand(floor..ceiling)
  end
end

#
# Spot Checking
#

require 'json'

module Enumerable
  def sum
    self.inject &:+
  end
  def mean
    self.sum / self.length.to_f
  end
  def sample_variance
    m = self.mean
    sum = self.inject(0){|accum, i| accum + (i-m)**2 }
    sum / (self.length - 1).to_f
  end
  def standard_deviation
    return Math.sqrt(self.sample_variance)
  end
end

counts = {}
200_000.times do
  (0..3).each do |i|
    res = Shuffler.shuffle((0..3).to_a)
    counts[res.join] ||= 0
    counts[res.join] += 1
  end
end

puts JSON.pretty_generate counts
puts "Standard Deviation: #{counts.values.standard_deviation}"
