class AddColumnClass < ActiveRecord::Migration
  def change
    add_column :school_classes, :avatar, :string
  end
end
