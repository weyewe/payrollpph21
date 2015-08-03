class CreateDivisions < ActiveRecord::Migration
  def change
    create_table :divisions do |t|
      t.integer :office_id
      t.integer :branch_office_id
      t.integer :department_id
      t.string :code
      t.string :name
      t.string :description
       
      t.timestamps
    end
  end
end
