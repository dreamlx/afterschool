class AddTeacherToWorkpaper < ActiveRecord::Migration
  def change
    add_column :work_papers, :teacher_id, :integer
  end
end
