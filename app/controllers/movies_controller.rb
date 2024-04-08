class MoviesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_movie, only: [:show]

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
    @trailer = MoviedbApi.new.play_trailers(id)
    @casts = MoviedbApi.new.movie_credits(id)
    @recommended = MoviedbApi.new.recommended_movies(id)
  end

  private

  def set_movie
    @movie = MoviedbApi.new.get_movie_details(params[:id])
  end
end
