class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users, id: :uuid do |t|
      t.string :username
      t.text :bio
      t.string :first_name
      t.string :last_name
      t.integer :post_count, default: 0

      t.timestamps
    end
  end
end
