class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
      t.integer :employee_id
      t.datetime :date
      t.decimal :value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :interest,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :total,  :default => 0,  :precision => 14, :scale => 2
      t.integer :installment_time
      t.decimal :installment_value,  :default => 0,  :precision => 14, :scale => 2
      t.datetime :installment_start
      t.datetime :installment_end
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
