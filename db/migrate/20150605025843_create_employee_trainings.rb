class CreateEmployeeTrainings < ActiveRecord::Migration
  def change
    create_table :employee_trainings do |t|
      t.integer :employee_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :subject
      t.string :organizer
      t.string :place
      t.string :company
      t.string :result
      
      t.timestamps
    end
  end
end
