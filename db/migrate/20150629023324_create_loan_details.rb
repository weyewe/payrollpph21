class CreateLoanDetails < ActiveRecord::Migration
  def change
    create_table :loan_details do |t|
      t.integer :loan_id
      t.datetime :month
      t.decimal :amount,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_paid, :default => false
      t.boolean :is_closed, :default => false
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      t.string :description
      
      t.timestamps
    end
  end
end
