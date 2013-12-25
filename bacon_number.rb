# a basic breadth-first-search approach.

require 'set'

class Baconizer

  def initialize movies
    @movies = movies
  end

  def bacon_number starting_actor
    degrees = 0
    set = [starting_actor]
    while degrees < 6
      next_degree_of_separation = co_stars(*set)
      break if next_degree_of_separation.include? "kevin" || set == next_degree_of_separation
      set = next_degree_of_separation
      degrees += 1
    end
    degrees if next_degree_of_separation.include? "kevin"
  end

  def co_stars *actors_to_find
    set_of_actors = Set.new
    @movies.delete_if do |movie, actors| 
      if !(actors & actors_to_find).empty? then set_of_actors += actors else false end
    end
    set_of_actors
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

%w{ben manny henry sally}.each do |actor|
  baconizer = Baconizer.new movies.dup
  puts baconizer.bacon_number actor
  #=> 4, 0, 2, nil
end
