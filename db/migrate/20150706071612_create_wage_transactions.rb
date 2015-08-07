class CreateWageTransactions < ActiveRecord::Migration
  def change
    create_table :wage_transactions do |t|
      t.integer :employee_id
      t.integer :year
      t.integer :month
      t.decimal :basic_salary,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :seniority_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :functional_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :meal_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :transport_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :phone_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :medical_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :overtime,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph21_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :other_allowance_taxable,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :other_allowance_non_taxable,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :thr,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :commission,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jkk,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jkm,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jht_company,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jp_company,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :bpjs_company,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :other_expense_taxable,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :other_expense_non_taxable,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :loan,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :cooperative_dues,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jht_employee,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jp_employee,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :bpjs_employee,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :bruto,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :biaya_jabatan,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :netto,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :netto_yearly,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :ptkp,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pkp,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph_yearly,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph21_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph21_non_npwp,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :sisa_gaji,  :default => 0,  :precision => 14, :scale => 2
      
      t.timestamps
    end
  end
end
