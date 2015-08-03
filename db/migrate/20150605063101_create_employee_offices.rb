class CreateEmployeeOffices < ActiveRecord::Migration
  def change
    create_table :employee_offices do |t|
      t.integer :employee_id
      t.integer :office_id
      t.integer :branch_office_id
      t.integer :department_id
      t.integer :division_id
      t.integer :title_id
      
      t.timestamps
    end
  end
end
