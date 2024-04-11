class CommentsController < ApplicationController
  before_action :authenticate_user!

  def new
    @comment = Comment.new
  end

  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.build(comment_params)
    @comment.author = current_user
    if @comment.save
      flash[:notice] = 'Comment was successfully created'
    else
      flash[:alert] = @comment.errors.full_messages.join(', ')
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:thought, :post_id, :author_id)
  end
end
