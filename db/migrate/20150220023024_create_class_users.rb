class CreateClassUsers < ActiveRecord::Migration
  def change
    create_table :class_users do |t|
      t.references :user, index: true
      t.references :school_class, index: true

      t.timestamps null: false
    end
    add_foreign_key :class_users, :users
    add_foreign_key :class_users, :school_classes
  end
end
