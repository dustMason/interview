# You decide to test if your oddly-mathematical heating company is fulfilling its
# All-Time Max, Min, Mean and Mode Temperature Guarantee™. Write a class
# TempTracker with these methods:
# 
# insert()—records a new temperature
# get_max()—returns the highest temp we've seen so far
# get_min()—returns the lowest temp we've seen so far
# get_mean()—returns the mean ↴ of all temps we've seen so far
# get_mode()—returns a mode ↴ of all temps we've seen so far

# Optimize for space and time. Favor speeding up the getter functions get_max(),
# get_min(), get_mean(), and get_mode() over speeding up the insert() function.
# 
# get_mean() should return a float, but the rest of the getter functions can
# return integers. Temperatures will all be inserted as integers. We'll record our
# temperatures in Fahrenheit, so we can assume they'll all be in the range 0..110.
# 
# If there is more than one mode, return any of the modes.

class TempTracker
  def initialize
    @count = 0
    @readings = Array.new(110) { |_| 0 }
  end
  
  def insert temp
    @min ||= temp
    @max ||= temp
    @mean ||= 0.0
    
    @count += 1
    @readings[temp] ||= 0
    @readings[temp] += 1
    
    @min = temp if temp < @min
    @max = temp if temp > @max
    @mean = ((@mean * (@count - 1)) + temp) / @count
    
    _mode_count = 0
    @readings.each_with_index do |count, temp|
      if count > _mode_count
        @mode = temp
        _mode_count = count
      end
    end
  end
  
  def get_max; @max; end
  def get_min; @min; end
  def get_mean; @mean; end
  def get_mode; @mode; end
end

{
  [10, 15, 26, 23, 25, 10] => [26, 10, (109.0 / 6), 10]
}.each do |input, output|
  
  tracker = TempTracker.new
  input.each { |f| tracker.insert f }
  result = [tracker.get_max, tracker.get_min, tracker.get_mean, tracker.get_mode]
  
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
