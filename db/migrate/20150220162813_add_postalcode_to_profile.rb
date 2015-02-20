class AddPostalcodeToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :postalcode, :string
  end
end
