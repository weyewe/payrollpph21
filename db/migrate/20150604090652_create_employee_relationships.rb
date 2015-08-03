class CreateEmployeeRelationships < ActiveRecord::Migration
  def change
    create_table :employee_relationships do |t|
      t.integer :employee_id
      t.string :name
      t.integer :relationship
      t.datetime :date_of_birth
      t.string :gender
      t.string :education
      t.string :employment
      t.string :address

      t.timestamps
    end
  end
end
