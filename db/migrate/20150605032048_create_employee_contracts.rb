class CreateEmployeeContracts < ActiveRecord::Migration
  def change
    create_table :employee_contracts do |t|
      t.integer :employee_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :no
      t.string :outsource_company
      t.string :description
      
      t.timestamps
    end
  end
end
