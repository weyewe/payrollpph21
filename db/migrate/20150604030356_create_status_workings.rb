class CreateStatusWorkings < ActiveRecord::Migration
  def change
    create_table :status_workings do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.boolean :is_contract, :default => true
      t.string :description
      
      t.timestamps
    end
  end
end
