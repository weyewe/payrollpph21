class CreateThrs < ActiveRecord::Migration
  def change
    create_table :thrs do |t|
      t.integer :employee_id
      t.datetime :date
      t.decimal :value,  :default => 0,  :precision => 14, :scale => 2
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
