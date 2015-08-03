class CreatePph21s < ActiveRecord::Migration
  def change
    create_table :pph21s do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.string :description
      
      t.timestamps
    end
  end
end
