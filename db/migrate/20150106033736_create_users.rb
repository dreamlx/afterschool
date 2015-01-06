class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :nickname
      t.string :phone

      t.timestamps null: false
    end
  end
end
