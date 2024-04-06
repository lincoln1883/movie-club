class Like < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :user_id, dependent: :destroy
  belongs_to :post, foreign_key: :post_id, dependent: :destroy

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  private

  def increment_likes_count
    post.increment!(:likes_count)
  end

  def decrement_likes_count
    post.decrement!(:likes_count)
  end
end
