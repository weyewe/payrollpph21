class CreateOvertimeDetails < ActiveRecord::Migration
  def change
    create_table :overtime_details do |t|
      t.integer :overtime_id
      t.float :from_value
      t.float :to_value
      t.float :multiplier
      t.string :description
      
      t.timestamps
    end
  end
end
