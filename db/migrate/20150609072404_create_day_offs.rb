class CreateDayOffs < ActiveRecord::Migration
  def change
    create_table :day_offs do |t|
      t.integer :office_id
      t.integer :overtime_id
      t.datetime :date
      t.string :description
      
      t.timestamps
    end
  end
end
