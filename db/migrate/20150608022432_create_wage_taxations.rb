class CreateWageTaxations < ActiveRecord::Migration
  def change
    create_table :wage_taxations do |t|
      t.integer :employee_id
      t.datetime :effective_date
      t.integer :marital_status
      t.integer :number_of_children
      t.integer :tax_method
      t.integer :tax_code_id
      t.string :npwp
      t.datetime :npwp_registered_date
      t.string :npwp_address

      t.timestamps
    end
  end
end
