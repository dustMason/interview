# a basic breadth-first-search approach. could be heavily optimized by eliminating
# the already searched movies from the input set.

def bacon_number starting_actor, movies
  degrees = 0
  set = co_stars [starting_actor], movies
  while degrees < 6
    break if set.include? "kevin"
    next_degree_of_separation = co_stars(set, movies)
    break if set == next_degree_of_separation
    set = next_degree_of_separation
    degrees += 1
  end
  degrees if set.include? "kevin"
end

def co_stars actors_to_find, movies
  movies.select { |movie, actors| !(actors & actors_to_find.to_a).empty? }.values.flatten.uniq
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

puts bacon_number "ben", movies #=> 4
puts bacon_number "manny", movies #=> 0
puts bacon_number "henry", movies #=> 2
puts bacon_number "sally", movies #=> nil
