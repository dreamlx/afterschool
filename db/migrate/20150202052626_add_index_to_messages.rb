class AddIndexToMessages < ActiveRecord::Migration
  def change
    add_index :messages, :message_type
  end
end
