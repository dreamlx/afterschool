class AddAvatarsToMediaResources < ActiveRecord::Migration
  def change
    add_column :media_resources, :avatar, :string
  end
end
