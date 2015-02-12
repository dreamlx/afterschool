class CreateClassPapers < ActiveRecord::Migration
  def change
    create_table :class_papers do |t|
      t.integer :work_paper_id
      t.integer :school_class_id

      t.timestamps null: false
    end

    add_index :class_papers, :work_paper_id
    add_index :class_papers, :school_class_id
    add_index :class_papers, [:work_paper_id, :school_class_id], unique: true
  end
end
