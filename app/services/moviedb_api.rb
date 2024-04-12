require 'httparty'

class MoviedbApi
  include HTTParty
  base_uri 'https://api.themoviedb.org/3'

  def initialize
    @api_key = ENV['MOVIEDB_API_KEY']
    @location_api = ENV['GEOAPIFY_API_KEY']
  end

  def poster
    response = self.class.get("/movie/550?api_key=#{@api_key}")
    response['backdrop_path']
  end

  def popular
    page = (1..5).to_a.sample
    response = self.class.get("/discover/movie?include_adult=false&include_video=false&language=en-US&page=#{page}&sort_by=popularity.desc&api_key=#{@api_key}")
    response['results']
  end

  def now_playing
    response = self.class.get("/movie/now_playing?language=en-US&page=1&api_key=#{@api_key}")
    response.parsed_response['results']
  end

  def upcoming
    response = self.class.get("/movie/upcoming?language=en-US&page=1&api_key=#{@api_key}")
    response.parsed_response['results']
  end

  def top_rated
    response = self.class.get("/movie/top_rated?language=en-US&page=1&api_key=#{@api_key}")
    response.parsed_response['results']
  end

  def get_movie_details(id)
    begin
      response = self.class.get("/movie/#{id}?api_key=#{@api_key}&language=en-US")
    rescue
      response = nil
    end
    response
  end

  def play_trailers(id)
    response = self.class.get("/movie/#{id}/videos?language=en-US&api_key=#{@api_key}")
    trailers = response.parsed_response['results']
    trailers.slice(0, 2).map { |trailer| trailer['key'] } if trailers.present?
  end

  def watch_providers(id, location)
    response = self.class.get("/movie/#{id}/watch/providers?api_key=#{@api_key}")
    response['results']
  end

  def movie_credits(id)
    response = self.class.get("/movie/#{id}/credits?language=en-US&api_key=#{@api_key}")
    response.parsed_response['cast'].slice(0, 6)
  end

  def recommended_movies(id)
    response = self.class.get("/movie/#{id}/recommendations?language=en-US&api_key=#{@api_key}")
    response.parsed_response['results']
  end

  def search_movie(query)
    response = self.class.get("/search/movie?api_key=#{@api_key}&query=#{query}")
    response['results']
  end

  def service_location
    response = self.class.get("https://api.geoapify.com/v1/ipinfo?apiKey=#{@location_api}")
    response['country']['iso_code']
  end
end
