class CreateWageTransactions < ActiveRecord::Migration
  def change
    create_table :wage_transactions do |t|
      t.integer :employee_id
      t.datetime :month
      t.float :basic_salary, :default => 0
      t.float :seniority_allowance, :default => 0
      t.float :functional_allowance, :default => 0
      t.float :meal_allowance, :default => 0
      t.float :transport_allowance, :default => 0
      t.float :phone_allowance, :default => 0
      t.float :medical_allowance, :default => 0
      t.float :overtime, :default => 0
      t.float :pph21_allowance, :default => 0
      t.float :other_allowance_taxable, :default => 0
      t.float :other_allowance_non_taxable, :default => 0
      t.float :thr, :default => 0
      t.float :commission, :default => 0
      t.float :jkk, :default => 0
      t.float :jkm, :default => 0
      t.float :jht_company, :default => 0
      t.float :bpjs_company, :default => 0
      t.float :other_expense_taxable, :default => 0
      t.float :other_expense_non_taxable, :default => 0
      t.float :loan, :default => 0
      t.float :cooperative_dues, :default => 0
      t.float :jht_employee, :default => 0
      t.float :bpjs_employee, :default => 0
      t.float :pph21_value, :default => 0
      t.float :pph21_non_npwp, :default => 0
      
      t.timestamps
    end
  end
end
