class CreatePph21NonEmployeeAllocations < ActiveRecord::Migration
  def change
    create_table :pph21_non_employee_allocations do |t|
      t.integer :pph21_non_employee_id
      t.decimal :bruto_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :dpp_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :prosen_dpp,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :prosen_pph,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph21_value,  :default => 0,  :precision => 14, :scale => 2
      
      t.timestamps
    end
  end
end
