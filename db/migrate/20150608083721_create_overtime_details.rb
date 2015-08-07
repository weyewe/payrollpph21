class CreateOvertimeDetails < ActiveRecord::Migration
  def change
    create_table :overtime_details do |t|
      t.integer :overtime_id
      t.decimal :from_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :to_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :multiplier,  :default => 0,  :precision => 14, :scale => 2
      t.string :description
      
      t.timestamps
    end
  end
end
