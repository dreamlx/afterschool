class AddDescriptionToMediaResources < ActiveRecord::Migration
  def change
    add_column :media_resources, :description, :text
  end
end
