class CreatePph21Details < ActiveRecord::Migration
  def change
    create_table :pph21_details do |t|
      t.integer :pph21_id
      t.decimal :percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :from_value,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :to_value,  :default => 0,  :precision => 14, :scale => 2
      t.boolean :is_up, :default => false
      t.string :description
      
      t.timestamps
    end
  end
end
