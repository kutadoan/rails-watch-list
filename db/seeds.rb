require "open-uri"
require "json"

url = "https://tmdb.lewagon.com/movie/top_rated"
response = URI.parse(url).read
data = JSON.parse(response)

data.fetch("results").each do |film|
  movie = Movie.find_or_initialize_by(title: film.fetch("title"))
  movie.overview = film["overview"]
  movie.rating = film["vote_average"]

  if film["poster_path"].present?
    movie.poster_url = "https://image.tmdb.org/t/p/w500#{film['poster_path']}"
  end

  movie.save!
  puts "Film enregistré : #{movie.title}"
end
