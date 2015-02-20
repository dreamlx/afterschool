class CreateClassStudents < ActiveRecord::Migration
  def change
    create_table :class_students do |t|
      t.references :student, index: true
      t.references :school_class, index: true

      t.timestamps null: false
    end
    #add_foreign_key :class_students, :students
    #add_foreign_key :class_students, :school_classes
  end
end
