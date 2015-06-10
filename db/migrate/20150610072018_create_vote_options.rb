class CreateVoteOptions < ActiveRecord::Migration
  def change
    create_table :vote_options do |t|
      t.integer :vote_id
      t.string :title

      t.timestamps null: false
    end
  end
end
