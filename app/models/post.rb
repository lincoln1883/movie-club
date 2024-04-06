class Post < ApplicationRecord
  belongs_to :author, class_name: "User", foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes

  validates :review, presence: true, length: {minimum: 3, maximum: 100}
  validates :rating, presence: true, numericality: {greater_than_or_equal_to: 0, less_than_or_equal_to: 10}
  validates :title, presence: true, length: {minimum: 3, maximum: 50}
  validates :overview, presence: true, length: {minimum: 5, maximum: 500}
  validates :image, presence: true
  validates :release_date, presence: true
  validates :movie_id, presence: true
  validates :runtime, presence: true

  after_create :increase_posts_count
  after_destroy :decrease_posts_count

  def recent_comments
    comments.order(created_at: :desc).limit(5)
  end

  private

  def increase_posts_count
    author.increment!(:post_count)
  end

  def decrease_posts_count
    author.decrement!(:post_count)
  end
end
