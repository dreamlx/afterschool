class CreateHomeWorks < ActiveRecord::Migration
  def change
    create_table :home_works do |t|
      t.string :title
      t.text :description
      t.references :student, index: true
      t.references :work_paper, index: true

      t.timestamps null: false
    end
    #add_foreign_key :home_works, :students
    #add_foreign_key :home_works, :work_papers
  end
end
