class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :employee_id
      t.datetime :date
      t.float :value
      t.float :interest
      t.float :total
      t.integer :installment_time
      t.float :installment_value
      t.datetime :installment_start
      t.datetime :installment_end
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
