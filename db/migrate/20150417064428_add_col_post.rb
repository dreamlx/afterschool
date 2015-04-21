class AddColPost < ActiveRecord::Migration
  def change
    add_column :posts, :school_class_id, :integer
  end
end
