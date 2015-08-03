class CreateOtherExpenses < ActiveRecord::Migration
  def change
    create_table :other_expenses do |t|
      t.integer :employee_id
      t.datetime :date
      t.boolean :is_taxable, :default => true
      t.float :value
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
