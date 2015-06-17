class AddColumState < ActiveRecord::Migration
  def change
      add_column :votes, :state, :string
  end
end
