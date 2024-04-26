# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    @like = current_user.likes.new(like_params)
    if !@like.save
      flash[:alert] = @like.errors.full_messages.to_sentence
    end
    redirect_to likes_path
  end

  def destroy
    @like = current_user.likes.find(params[:id])
    likeable = @like.likeable
    @like.destroy
    redirect_to likeable

    puts likeable.inspect
  end

  private

  def like_params
    params.require(:like).permit(:likeable_id, :likeable_type, :author_id)
  end
end
