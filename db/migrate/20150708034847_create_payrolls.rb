class CreatePayrolls < ActiveRecord::Migration
  def change
    create_table :payrolls do |t|
      t.integer :office_id
      t.datetime :month
      t.datetime :start_date
      t.datetime :end_date
      
      t.timestamps
    end
  end
end
