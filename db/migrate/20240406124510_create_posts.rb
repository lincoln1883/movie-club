class CreatePosts < ActiveRecord::Migration[7.1]
  def change
    create_table :posts, id: :uuid do |t|
      t.references :user, null: false, foreign_key: true, type: :uuid
      t.text :review
      t.float :rating
      t.string :title
      t.string :overview
      t.string :image
      t.string :genres, array: true, default: []
      t.string :release_date
      t.string :movie_id
      t.string :runtime
      t.integer :comments_count, default: 0
      t.integer :likes_count, default: 0

      t.timestamps
    end
  end
end
