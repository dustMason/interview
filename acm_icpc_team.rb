# You are given a list of  people who are attending ACM-ICPC World Finals. Each of
# them are either well versed in a topic or they are not. Find out the maximum
# number of topics a 2-person team can know. And also find out how many teams can
# know that maximum number of topics.
# 
# Note Suppose a, b, and c are three different people, then (a,b) and (b,c) are
# counted as two different teams.

def team_topic_stats _people
  people = _people.map { |p| p.to_i(2) }
  counts = Array.new(_people.first.size, 0)
  
  people.combination(2).lazy.each do |a, b|
    counts[(a | b).to_s(2).count("1")-1] += 1
  end
  
  best = counts.rindex { |c| c != 0 } + 1
  teams = counts[best-1]
  puts best, teams
end
