class AddResourceableToMediaResource < ActiveRecord::Migration
  def change
    add_reference :media_resources, :media_resourceable, polymorphic: true
  end
end
