class AddColumnToMediaResource < ActiveRecord::Migration
  def change
    add_column :media_resources, :content_type, :string
    add_column :media_resources, :file_size, :integer
  end
end
