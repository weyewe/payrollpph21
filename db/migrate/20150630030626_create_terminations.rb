class CreateTerminations < ActiveRecord::Migration
  def change
    create_table :terminations do |t|
      t.integer :employee_id
      t.datetime :date
      t.string :description
      t.boolean :is_approved, :default => false
      t.datetime :approved_at
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
        
      t.timestamps
    end
  end
end
