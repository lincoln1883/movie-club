class MoviesController < ApplicationController
  def index
    @poster = MoviedbApi.new.poster
    @popular = MoviedbApi.new.popular
    @now_playing = MoviedbApi.new.now_playing
    @upcoming = MoviedbApi.new.upcoming
    @top_rated = MoviedbApi.new.top_rated
  end

  def show
    id = params[:id]
    @movie = MoviedbApi.new.get_movie_details(id)
    @location = MoviedbApi.new.service_location
    @providers = MoviedbApi.new.watch_providers(id, location: @location)
    # @trailer = MoviedbApi.new.play_trailers(id)
    # @casts = MoviedbApi.new.movie_credits(id)
    # @recommended = MoviedbApi.new.recommended_movies(id)
    # @new_movie = Movie.new(
    #   user_id: current_user.id,
    #   movie_id: @movie['id'],
    #   title: @movie['title'],
    #   overview: @movie['overview'],
    #   poster_path: @movie['poster_path'],
    #   released_date: @movie['release_date'],
    #   average_vote: @movie['vote_average'],
    #   runtime: @movie['runtime'],
    #   genres: @movie['genres'])
  end
end
