class CreateClassTeachers < ActiveRecord::Migration
  def change
    create_table :class_teachers do |t|
      t.integer :teacher_id
      t.integer :school_class_id

      t.timestamps null: false
    end

    add_index :class_teachers, :teacher_id
    add_index :class_teachers, :school_class_id
    add_index :class_teachers, [:teacher_id, :school_class_id], unique: true
  end
end
