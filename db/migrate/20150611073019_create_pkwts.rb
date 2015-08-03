class CreatePkwts < ActiveRecord::Migration
  def change
    create_table :pkwts do |t|
      t.integer :office_id
      t.string :no
      t.boolean :is_employee, :default => false
      t.integer :employee_id
      t.integer :length_of_contract
      t.datetime :start_date
      t.datetime :end_date
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
