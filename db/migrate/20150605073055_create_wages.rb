class CreateWages < ActiveRecord::Migration
  def change
    create_table :wages do |t|
      t.integer :employee_id
      t.datetime :effective_date
      t.integer :pph21_id
      t.integer :ptkp_id
      t.integer :jamsostek_id
      t.boolean :is_daily_basic, :default => false
      t.decimal :basic_salary,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_seniority, :default => false
      t.decimal :seniority_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_functional, :default => false
      t.decimal :functional_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_meal, :default => false
      t.decimal :meal_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_transport, :default => false
      t.decimal :transport_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_communication, :default => false
      t.decimal :communication_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_daily_medical, :default => false
      t.decimal :medical_allowance,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_cooperative_member, :default => false
      t.decimal :cooperative_dues,  :default => 0,  :precision => 14, :scale => 2
      
      t.timestamps
    end
  end
end
