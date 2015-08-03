class CreateEmployeeEducations < ActiveRecord::Migration
  def change
    create_table :employee_educations do |t|
      t.integer :employee_id
      t.integer :level
      t.string :range_year
      t.string :majors
      t.string :school
      t.string :city
      t.integer :country
      
      t.timestamps
    end
  end
end
