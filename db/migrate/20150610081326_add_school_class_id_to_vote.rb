class AddSchoolClassIdToVote < ActiveRecord::Migration
  def change
    add_column :votes, :school_class_id, :integer
    add_column :votes, :teacher_id, :integer
  end
end
