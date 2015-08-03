class CreateOvertimeAllocations < ActiveRecord::Migration
  def change
    create_table :overtime_allocations do |t|
      t.integer :employee_id
      t.integer :overtime_id
      t.datetime :date
      t.integer :start_time
      t.integer :end_time
      t.string :description
      t.boolean :is_approved, :default => false
      t.datetime :approved_at
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
