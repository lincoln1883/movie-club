class Comment < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  belongs_to :post, class_name: "Post", foreign_key: :post_id
  has_many :likes, as: :likeable

  validates :thought, presence: true, length: {minimum: 3, maximum: 500}

  after_create :increment_comments_count
  after_destroy :decrement_comments_count

  private

  def increment_comments_count
    post.increment!(:comments_count)
  end

  def decrement_comments_count
    post.decrement!(:comments_count)
  end
end
