class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :employee_id
      t.integer :shift_id
      t.datetime :date
      t.integer :status  , :default => ATTENDANCE_STATUS[:present] # present, sick, bla bla lba
      t.integer :time_in
      t.integer :time_out
      t.boolean :is_late, :default => false
      t.integer :late_minute, :default => 0
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at

      t.timestamps
    end
  end
end
