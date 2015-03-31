class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts, force: true do |t|
      t.string :title
      t.text :body
      t.integer :user_id
    end
  end
end
