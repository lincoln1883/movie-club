# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: :author_id
  belongs_to :post, foreign_key: :post_id

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  validates :author_id, uniqueness: {scope: :post_id}

  private

  def increment_likes_count
    post.increment!(:likes_count)
  end

  def decrement_likes_count
    post.decrement!(:likes_count)
  end
end
