class AddSchoolclassIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :school_class_id, :integer
  end
end
