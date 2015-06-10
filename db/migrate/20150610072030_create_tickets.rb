class CreateTickets < ActiveRecord::Migration
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :vote_option_id

      t.timestamps null: false
    end
  end
end
