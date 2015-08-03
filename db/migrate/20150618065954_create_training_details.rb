class CreateTrainingDetails < ActiveRecord::Migration
  def change
    create_table :training_details do |t|
      t.integer :training_id
      t.integer :employee_id
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
