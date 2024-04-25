# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)
    if !@like.save
      flash[:alert] = @like.errors.full_messages.join(', ')
    end
    redirect_to likes_path
  end

  def destroy
    @like = current_user.likes.find_by(id: params[:id])
    post = @like.post
    @like.destroy
    redirect_to post
  end

  private

  def like_params
    params.require(:like).permit(:post_id, :author_id)
  end
end
