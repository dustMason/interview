# Your company built an in-house calendar tool called HiCal. You want to add a
# feature to see the times in a day when everyone is available. To do this, you’ll
# need to know when any team is having a meeting. In HiCal, a meeting is stored as
# arrays ↴ of integers [start_time, end_time]. These integers represent the number
# of 30-minute blocks past 9:00am.
# 
# For example:
# 
#   [2, 3] # meeting from 10:00 – 10:30 am [6, 9] # meeting from 12:00 – 1:30 pm
# 
# Write a function merge_ranges() that takes an array of meeting time ranges and
# returns an array of condensed ranges.
# 
# For example, given:
# 
#   [[0, 1], [3, 5], [4, 8], [10, 12], [9, 10]]
# 
# your function would return:
# 
#   [[0, 1], [3, 8], [9, 12]]
# 
# Do not assume the meetings are in order. The meeting times are coming from
# multiple teams.
# 
# Write a solution that's efficient even when we can't put a nice upper bound on
# the numbers representing our time ranges. Here we've simplified our times down
# to the number of 30-minute slots past 9:00 am. But we want the function to work
# even for very large numbers, like Unix timestamps. In any case, the spirit of
# the challenge is to merge meetings where start_time and end_time don't have an
# upper bound.

class Merger
  def self.merge_ranges meeting_time_ranges=[]
    raise 'Need at least 1 meeting' if meeting_time_ranges.empty?
    
    # sort by start time
    times = meeting_time_ranges.sort { |a, b| a[0] - b[0] }
    
    merged = []
    current_meeting = times.shift
    
    times.each do |meeting|
      if meeting[0] <= current_meeting[1] && meeting[1] >= current_meeting[1]
        # this meeting overlaps the current one
        current_meeting[1] = meeting[1]
      elsif meeting[0] > current_meeting[1]
        # this meeting starts after the current one ends, its a new meeting
        merged << current_meeting
        current_meeting = [meeting[0], meeting[1]]
      end
    end
    
    merged << current_meeting
  end
end

{
  [[9, 10], [0, 1], [3, 5], [4, 8], [10, 12]] => [[0, 1], [3, 8], [9, 12]],
  [[0, 1], [3, 5], [4, 8], [10, 12], [9, 10]] => [[0, 1], [3, 8], [9, 12]],
  [[1, 2], [2, 3]] => [[1, 3]],
  [[1, 5], [2, 3]] => [[1, 5]],
  [[1, 10], [2, 6], [3, 5], [7, 9]] => [[1, 10]]
}.each do |input, output|
  result = Merger.merge_ranges input
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input.join('-')}, expected #{output.join('-')} but got #{result.join('-')}"
  end
end
