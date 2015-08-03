class CreateEmployeeSkills < ActiveRecord::Migration
  def change
    create_table :employee_skills do |t|
      t.integer :employee_id
      t.string :name
      t.integer :level
      t.string :description
      
      t.timestamps
    end
  end
end
