class CreateOvertimes < ActiveRecord::Migration
  def change
    create_table :overtimes do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.string :description
      
      t.timestamps
    end
  end
end
