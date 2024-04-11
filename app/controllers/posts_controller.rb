# frozen_string_literal: true
class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show]

  def index
    @posts = Post.includes(:author, :comments, :likes).all.order(created_at: :desc)
  end

  def show
    @post = Post.find(params[:id])
    @comments = @post.comments.includes(:author).all.order(created_at: :desc)
    @comment = Comment.new
    puts @comments.inspect
  end

  def new
    @post = Post.new
    @movie = MoviedbApi.new.get_movie_details(params[:movie_id])
  end

  def create
    @post = current_user.posts.build(post_params)
    @movie = MoviedbApi.new.get_movie_details(params[:post][:movie_id])

    # Set movie details in the post
    @post.title = @movie['title']
    @post.image = @movie['poster_path']
    @post.overview = @movie['overview']
    @post.release_date = @movie['release_date']
    @post.rating = @movie['vote_average']
    @post.runtime = @movie['runtime']
    @post.genres = @movie['genres'].map { |genre| genre['name'] }

    if @post.save
      redirect_to posts_path
      flash[:notice] = 'Post was successfully created'
    else
      redirect_to movies_path
      flash[:alert] = @post.errors.full_messages.join(', ')
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to post_path(@post)
      flash[:notice] = 'Post was successfully updated'
    else
      render action: 'edit'
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    if @post.destroy
      redirect_to posts_path
      flash[:notice] = 'Post was successfully deleted'
    else
      redirect_to post_path
      flash[:alert] = 'Post could not be deleted'
    end
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :overview, :author_id, :movie_id, :review, :rating, :image, :released_date, 
                                 :runtime, genres: [])
  end
end
