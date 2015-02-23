class AddStatusToHomeWork < ActiveRecord::Migration
  def change
    add_column :home_works, :state, :string
  end
end
