class CreateLeaveDetails < ActiveRecord::Migration
  def change
    create_table :leave_details do |t|
      t.integer :employee_id
      t.datetime :start_working
      t.integer :period_year
      t.datetime :start_period
      t.datetime :end_period
      t.integer :max_leave, :default => 0
      t.integer :used_leave, :default => 0
      t.integer :current_leave, :default => 0
      
      t.timestamps
    end
  end
end
