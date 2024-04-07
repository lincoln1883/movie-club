class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments
    @comment = Comment.new
  end

  def new
    @post = Post.new
    @movie = MoviedbApi.new.get_movie_details(params[:movie_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @movie = MoviedbApi.new.get_movie_details(params[:post][:movie_id])

    # Set movie details in the post
    @post.title = @movie["title"]
    @post.image = @movie["poster_path"]
    @post.overview = @movie["overview"]
    @post.release_date = @movie["release_date"]
    @post.rating = @movie["vote_average"]
    @post.runtime = @movie["runtime"]
    @post.genres = @movie["genres"].map { |genre| genre["name"] }

    if @post.save
      redirect_to post_path(@post)
      flash[:notice] = "Post was successfully created"
    else
      render :new
      flash[:alert] = @post.errors.full_messages.join(", ")
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :overview, :author_id, :movie_id, :review, :rating, :image, :released_date, :runtime, genres: [])
  end
end
