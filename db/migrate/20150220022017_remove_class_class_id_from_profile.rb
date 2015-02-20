class RemoveClassClassIdFromProfile < ActiveRecord::Migration
  def change
    remove_column :profiles, :class_id, :integer
  end
end
