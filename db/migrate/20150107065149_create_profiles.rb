class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :avatar
      t.string :address
      t.datetime :birthday
      t.string :gender
      t.integer :user_id
      t.integer :class_id
      t.string :student_number

      t.timestamps null: false
    end
  end
end
