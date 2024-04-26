# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :user, class_name: "User", foreign_key: :author_id
  belongs_to :likeable, polymorphic: true

  after_create :increment_likes_count
  after_destroy :decrement_likes_count

  validates :author_id, uniqueness: {scope: [:likeable_id, :likeable_type]}

  private

  def increment_likes_count
    likeable.increment!(:likes_count)
  end

  def decrement_likes_count
    likeable.decrement!(:likes_count)
  end
end
