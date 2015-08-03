class CreateUserPrivileges < ActiveRecord::Migration
  def change
    create_table :user_privileges do |t|
      t.integer :user_id
      t.integer :menu_id
      t.boolean :is_allow_read, :default => false
      t.boolean :is_allow_add, :default => false
      t.boolean :is_allow_edit, :default => false
      t.boolean :is_allow_delete, :default => false
      t.boolean :is_allow_print, :default => false
      t.boolean :is_allow_approve, :default => false
      
      t.timestamps
    end
  end
end
