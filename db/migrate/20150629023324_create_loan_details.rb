class CreateLoanDetails < ActiveRecord::Migration
  def change
    create_table :loan_details do |t|
      t.integer :loan_id
      t.datetime :month
      t.float :amount
      t.boolean :is_paid, :default => false
      t.boolean :is_closed, :default => false
      t.string :description
      
      t.timestamps
    end
  end
end
