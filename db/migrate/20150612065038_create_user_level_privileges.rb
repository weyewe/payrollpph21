class CreateUserLevelPrivileges < ActiveRecord::Migration
  def change
    create_table :user_level_privileges do |t|
      t.integer :user_id
      t.integer :level_id
      t.boolean :is_allow, :default => false
      
      t.timestamps
    end
  end
end
