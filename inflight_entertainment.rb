# You've built an inflight entertainment system with on-demand movie streaming.
# Users on longer flights like to start a second movie right when their first one
# ends, but they complain that the plane usually lands before they can see the
# ending. So you're building a feature for choosing two movies whose total
# runtimes will equal the exact flight length.
# 
# Write a function that takes an integer flight_length (in minutes) and an array
# of integers movie_lengths (in minutes) and returns a boolean indicating whether
# there are two numbers in movie_lengths whose sum equals flight_length.
# 
# When building your function:
# 
# Assume your users will watch exactly two movies
# Don't make your users watch the same movie twice
# Optimize for runtime over memory

class Entertainer
  def self.perfect_pair_of_movies? flight_length, movies=[]
    table = []
    exists = false
    movies.each do |movie|
      key = flight_length - movie
      if key >= 0 && table[key]
        exists = true
        break
      end
      table[movie] = true
    end
    exists
  end
end

# An O(n) solution that considers any pair of movies _shorter_ than the
# flight_length, not just a pair that equals flight_length.
class Entertainer2
  def self.enough_time_for_2_movies? flight_length, movies=[]
    best = []
    exists = false
    movies.each do |movie|
      if best.size < 2
        best << movie
      elsif movie < best[0]
        best[0] = movie
      elsif movie < best[1]
        best[1] = movie
      end
      if best.size == 2 && best[0] + best[1] <= flight_length
        exists = true
        break
      end
    end
    exists
  end
end

puts "Entertainer"
{
  [90, [45, 45]] => true,
  [1, [0, 1]] => true,
  [0, [0, 0]] => true,
  [90, [50, 120]] => false,
  [300, [30, 30, 30, 30, 30]] => false,
  [60, [30, 30, 30, 30, 30]] => true,
  [300, [230, 430, 310, 3001, 30]] => false,
  [0, []] => false,
  [10, [1, 11]] => false,
  [10, [11, 11, 11, 11, 11, 11, 11, 11, 11, 1]] => false,
  [10, [5]] => false,
}.each do |input, output|
  result = Entertainer.perfect_pair_of_movies? input[0], input[1]
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input}, expected #{output} but got #{result}"
  end
end

puts "Entertainer2"
{
  [90, [45, 45]] => true,
  [90, [50, 120]] => false,
  [300, [30, 30, 30, 30, 30]] => true,
  [60, [30, 30, 30, 30, 30]] => true,
  [300, [230, 430, 310, 3001, 30]] => false,
  [0, []] => false,
  [10, [1, 11]] => false,
  [10, [11, 11, 11, 11, 11, 11, 11, 11, 11, 1]] => false,
  [10, [5]] => false,
}.each do |input, output|
  result = Entertainer2.enough_time_for_2_movies? input[0], input[1]
  if result == output
    puts "PASS"
  else
    puts "FAIL given #{input}, expected #{output} but got #{result}"
  end
end
