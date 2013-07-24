class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :owner_id
      t.text :title
      t.text :body

      t.timestamps
    end
  end
end
