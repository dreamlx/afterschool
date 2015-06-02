class CreateInforms < ActiveRecord::Migration
  def change
    create_table :informs do |t|
      t.string :title
      t.text :body
      t.references :teacher
      t.references :school_class

      t.timestamps null: false
    end
  end
end
