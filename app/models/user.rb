class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable, :confirmable

  has_one_attached :avatar
  has_many :posts, foreign_key: :author_id, dependent: :destroy
  has_many :comments, through: :posts
  has_many :likes, through: :posts

  validates :username, presence: true, length: {minimum: 3}
  validates :post_count, numericality: {integer: true, greater_than_or_equal_to: 0}
  validates :bio, presence: true, length: {minimum: 5, maximum: 500}

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
