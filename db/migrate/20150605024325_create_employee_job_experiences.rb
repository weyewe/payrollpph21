class CreateEmployeeJobExperiences < ActiveRecord::Migration
  def change
    create_table :employee_job_experiences do |t|
      t.integer :employee_id
      t.string :company_name
      t.string :range_year
      t.string :last_job_title
      t.float :last_salary
      t.string :end_working_reason
      t.string :description
      
      t.timestamps
    end
  end
end
