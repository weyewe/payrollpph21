class CreatePph21NonEmployeeAllocations < ActiveRecord::Migration
  def change
    create_table :pph21_non_employee_allocations do |t|
      t.integer :pph21_non_employee_id
      t.float :bruto_value
      t.float :dpp_value, :default => 0
      t.float :prosen_dpp, :default => 0
      t.float :prosen_pph, :default => 0
      t.float :pph21_value, :default => 0
      
      t.timestamps
    end
  end
end
