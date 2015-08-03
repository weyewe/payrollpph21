class CreateWages < ActiveRecord::Migration
  def change
    create_table :wages do |t|
      t.integer :employee_id
      t.datetime :effective_date
      t.integer :pph21_id
      t.integer :ptkp_id
      t.integer :jamsostek_id
      t.boolean :is_daily_basic, :default => false
      t.float :basic_salary, :default => 0
      t.boolean :is_daily_seniority, :default => false
      t.float :seniority_allowance, :default => 0
      t.boolean :is_daily_functional, :default => false
      t.float :functional_allowance, :default => 0
      t.boolean :is_daily_meal, :default => false
      t.float :meal_allowance, :default => 0
      t.boolean :is_daily_transport, :default => false
      t.float :transport_allowance, :default => 0
      t.boolean :is_daily_communication, :default => false
      t.float :communication_allowance, :default => 0
      t.boolean :is_daily_medical, :default => false
      t.float :medical_allowance, :default => 0
      t.boolean :is_cooperative_member, :default => false
      t.float :cooperative_dues
      
      t.timestamps
    end
  end
end
