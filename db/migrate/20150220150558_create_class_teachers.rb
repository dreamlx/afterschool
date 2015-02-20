class CreateClassTeachers < ActiveRecord::Migration
  def change
    create_table :class_teachers do |t|
      t.references :teacher, index: true
      t.references :school_class, index: true

      t.timestamps null: false
    end
    #add_foreign_key :class_teachers, :teachers
    #add_foreign_key :class_teachers, :school_classes
  end
end
