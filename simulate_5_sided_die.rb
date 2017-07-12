# You have a function rand7() that generates a random integer from 1 to 7. Use
# it to write a function rand5() that generates a random integer from 1 to 5.
# rand7() returns each integer with equal probability. rand5() must also return
# each integer with equal probability.

def rand7
  rand * 7
end

class IsThisCheating
  def self.rand5 seed=nil
    seed ||= rand7
    ((seed / 7.0) * 5).ceil
  end
end

class ItCouldRunForever
  def self.rand5 seed=nil
    seed ||= rand7
    if seed > 5 then rand5 else seed.ceil end
  end
end

[IsThisCheating, ItCouldRunForever].each do |klass|
  counts = {}
  (1...70000).each do |s|
    res = klass.rand5 s/10000.0
    counts[res] ||= 0
    counts[res] += 1
  end

  puts counts
end
