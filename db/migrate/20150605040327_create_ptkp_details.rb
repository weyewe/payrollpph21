class CreatePtkpDetails < ActiveRecord::Migration
  def change
    create_table :ptkp_details do |t|
      t.integer :ptkp_id
      t.integer :marital_status
      t.integer :number_of_children
      t.decimal :value,  :default => 0,  :precision => 14, :scale => 2
      t.string :description
      
      t.timestamps
    end
  end
end
