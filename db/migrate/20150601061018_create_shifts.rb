class CreateShifts < ActiveRecord::Migration
  def change
    create_table :shifts do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.integer :start_time
      t.integer :duration
      t.string :description
      
      # t.datetime :start_time
      #t.integer :start_time  # 9:30 => 9*60 + 30 
      #t.integer :duration # in minutes 
      
      t.timestamps
    end
  end
end
