class CreateWorkReviews < ActiveRecord::Migration
  def change
    create_table :work_reviews do |t|
      t.references :teacher, index: true
      t.references :home_work, index: true
      t.integer :rate
      t.text :remark

      t.timestamps null: false
    end
    #add_foreign_key :work_reviews, :teachers
    #add_foreign_key :work_reviews, :home_works
  end
end
