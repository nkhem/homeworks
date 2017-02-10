def what_was_that_one_with(those_actors)
  # Find the movies starring all `those_actors` (an array of actor names).
  # Show each movie's title and id.

  Movie
    .select("movies.title, movies.id")
    .joins("JOIN castings ON castings.movie_id = movies.id")
    .joins("JOIN actors ON actors.id = castings.actor_id")
    .where("actors.name IN (?)", those_actors)
    .group("movies.id")
    .having("COUNT(*) = ?", those_actors.length)
end

def golden_age
  # Find the decade with the highest average movie score.
  Movie
    .group("yr - (yr % 10)")
    .order("AVG(score) DESC")
    .limit(1)
    .pluck("yr - (yr % 10) AS decade").first
end

def costars(name)
  # List the names of the actors that the named actor has ever appeared with.
  # Hint: use a subquery
  Actor
    .joins("JOIN castings ON actors.id = castings.actor_id")
    .joins("JOIN movies ON castings.movie_id = movies.id")
    .where("actors.name != ?", name)
    .where("movies.id IN (?)",
      Movie
        .joins("JOIN castings ON castings.movie_id = movies.id")
        .joins("JOIN actors ON actors.id = castings.actor_id")
        .where("actors.name = ?", name)
        .pluck("movies.id")
    )
    .pluck("DISTINCT actors.name")

end

def actor_out_of_work
  # Find the number of actors in the database who have not appeared in a movie
  Actor
    .joins("LEFT JOIN castings ON actors.id = castings.actor_id")
    .where("castings.movie_id IS NULL")
    .pluck("COUNT(*)").first
end

def starring(whazzername)
  # Find the movies with an actor who had a name like `whazzername`.
  # A name is like whazzername if the actor's name contains all of the letters in whazzername,
  # ignoring case, in order.

  # ex. "Sylvester Stallone" is like "sylvester" and "lester stone" but not like "stallone sylvester" or "zylvester ztallone"
  Movie
    .select("movies.*")
    .joins("JOIN castings ON movies.id = castings.movie_id")
    .joins("JOIN actors ON castings.actor_id = actors.id")
    .where("lower(actors.name) LIKE ?", "%" + whazzername.downcase.chars.join("%") + "%")
end

def longest_career
  # Find the 3 actors who had the longest careers
  # (the greatest time between first and last movie).
  # Order by actor names. Show each actor's id, name, and the length of their career.
  Actor
    .select("actors.id, actors.name, (MAX(movies.yr) - MIN(movies.yr)) AS career")
    .joins("JOIN castings ON actors.id = castings.actor_id")
    .joins("JOIN movies ON castings.movie_id = movies.id")
    .group("actors.id")
    .order("(MAX(movies.yr) - MIN(movies.yr)) DESC, actors.name")
    .limit(3)
end
