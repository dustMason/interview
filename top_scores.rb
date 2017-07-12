# You created a game that is more popular than Angry Birds.

# Each round, players receive a score between 0 and 100, which you use to rank
# them from highest to lowest. So far you're using an algorithm that sorts in  O (
# n lg n ) O(nlgn) time, but players are complaining that their rankings aren't
# updated fast enough. You need a faster sorting algorithm.  Write a function
# that takes:  an array of unsorted_scores the highest_possible_score in the
# game and returns a sorted array of scores in less than  O ( n lg n ) O(nlgn)
# time.

# We’re defining n as the number of unsorted_scores because we’re expecting
# the number of players to keep climbing.  And we'll treat
# highest_possible_score as a constant instead of factoring it into our big O
# time and space costs, because the highest possible score isn’t going to
# change. Even if we do redesign the game a little, the scores will stay around
# the same order of magnitude.

# Answer:
# Running time is roughly O(3n) since Array#compact is O(n) and Array#flatten(1)
# is O(n). It is fairly inefficient in terms of space due to the use of a separate
# (and nested) array. Space complexity could be improved by storing a count of
# each score in the nested array, then filling it out with values before returning.

class TopScores
  MAX_SCORE = 100
  
  def self.sort scores
    buckets = Array.new(MAX_SCORE)
    scores.each do |score|
      key = MAX_SCORE - score
      buckets[key] ||= []
      buckets[key] << score
    end
    buckets.compact.flatten(1)
  end
end

{
  [37, 89, 41, 65, 91, 53] => [91, 89, 65, 53, 41, 37],
  [37, 37, 89, 41, 91, 65, 91, 53] => [91, 91, 89, 65, 53, 41, 37, 37]
}.each do |input, output|
  result = TopScores.sort input
  if result == output
    puts "pass"
  else
    puts "given #{input}, expected #{output} but got #{result}"
  end
end
