class CreateAttendanceLogs < ActiveRecord::Migration
  def change
    create_table :attendance_logs do |t|
      t.integer :office_id
      t.datetime :date
      t.integer :enroll_id
      t.integer :in_out
      
      t.timestamps
    end
  end
end
