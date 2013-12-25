class Baconizer
  @@limit = 6

  def self.bacon_number actor, movies
    stack = [actor]
    degrees = 0
    while degrees < @@limit
      return degrees if stack.include? 'kevin'
      stack = movies.values.select { |actors| !(actors & stack).empty? }.flatten # - stack
      degrees += 1
    end
    degrees if stack.include? 'kevin'
  end
end


movies = {
  movieA: %w{andy ben candice},
  movieB: %w{dan ernie fred andy},
  movieC: %w{greg henry izzy dan},
  movieD: %w{jordan kelly leslie greg},
  movieE: %w{manny ned oscar kevin jordan},
  movieF: %w{penny quentin roger sally},
  movieG: %w{sally ted uffie}
}

%w{ben manny henry sally kevin}.each do |actor|
  puts Baconizer.bacon_number actor, movies #=> 5, 1, 3, nil, 0
end
