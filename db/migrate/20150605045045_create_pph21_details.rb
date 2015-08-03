class CreatePph21Details < ActiveRecord::Migration
  def change
    create_table :pph21_details do |t|
      t.integer :pph21_id
      t.integer :percentage
      t.float :from_value
      t.float :to_value
      t.boolean :is_up, :default => false
      t.string :description
      
      t.timestamps
    end
  end
end
