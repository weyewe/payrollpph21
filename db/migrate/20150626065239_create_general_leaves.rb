class CreateGeneralLeaves < ActiveRecord::Migration
  def change
    create_table :general_leaves do |t|
      t.integer :office_id
      t.datetime :date
      t.string :description
      
      t.timestamps
    end
  end
end
