class CreatePph21NonEmployees < ActiveRecord::Migration
  def change
    create_table :pph21_non_employees do |t|
      t.integer :office_id
      t.string :nik
      t.string :name
      t.string :address
      t.string :npwp, :default => ""
      t.integer :marital_status
      t.integer :number_of_children
      t.integer :tax_code_id
      t.integer :npwp_method, :default => 0
      
      t.timestamps
    end
  end
end
