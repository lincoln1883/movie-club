class MakeLikesPolymorphic < ActiveRecord::Migration[7.1]
  def change
    remove_index :likes, [:author_id, :post_id]

    rename_column :likes, :post_id, :likeable_id
    add_column :likes, :likeable_type, :string
    add_index :likes, [:likeable_id, :likeable_type, :author_id], unique: true
    add_index :likes, [:likeable_id, :likeable_type]
  end
end
