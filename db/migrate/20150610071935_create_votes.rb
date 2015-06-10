class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.string :title
      t.boolean :is_multi

      t.timestamps null: false
    end
  end
end
