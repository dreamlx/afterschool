class CreateWorkPapers < ActiveRecord::Migration
  def change
    create_table :work_papers do |t|
      t.string :title
      t.text :description
      t.string :paper_type

      t.timestamps null: false
    end
  end
end
