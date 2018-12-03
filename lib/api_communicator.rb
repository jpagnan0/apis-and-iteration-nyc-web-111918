require 'rest-client'
require 'json'
require 'pry'




def get_character_movies_from_api(character_name)
  #make the web request
  response_string = RestClient.get("http://www.swapi.co/api/people/")
  response_hash = JSON.parse(response_string)

  # iterate over the response hash to find the collection of `films` for the given
  #   `character`
  character = response_hash["results"].select do |character_info|
    character_info["name"] == character_name
  end

  character_films = character[0]["films"]

  #binding.pry
  # collect those film API urls, make a web request to each URL to get the info
  #  for that film

  # return value of this method should be collection of info about each film.
  #  i.e. an array of hashes in which each hash reps a given film
  # this collection will be the argument given to `print_movies`
  #  and that method will do some nice presentation stuff like puts out a list
  #  of movies by title. Have a play around with the puts with other info about a given film.
end

def print_movies(films)
  # some iteration magic and puts out the movies in a nice list
  films.each do |film_url|
    film_list = JSON.parse(RestClient.get(film_url))
    puts "Movie Title: #{film_list["title"]}"
    60.times do
      print "="
    end
    puts ""
    puts "\nDirector: #{film_list["director"]}"
    60.times do
      print "="
    end
    puts ""
    puts "\nProducer: #{film_list["producer"]}"
    60.times do
      print "="
    end
    puts ""
    puts "\nRelease Date: #{film_list["release_date"]}"
    60.times do
      print "="
    end
    puts ""
    puts "\nCharacters: #{film_list["characters"]}"
    puts "<*******************************************************>"
    # binding.pry
  end
end

def show_character_movies(character)
  films = get_character_movies_from_api(character)
  print_movies(films)
end

## BONUS

# that `get_character_movies_from_api` method is probably pretty long. Does it do more than one job?
# can you split it up into helper methods?
