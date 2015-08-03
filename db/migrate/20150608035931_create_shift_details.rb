class CreateShiftDetails < ActiveRecord::Migration
  def change
    create_table :shift_details do |t|
      t.integer :shift_id
      t.integer :day_code
      t.integer :start_time  # 9:30 => 9*60 + 30 
      t.integer :duration # in minutes 
      
      t.timestamps
    end
  end
end
