class CreateRecruitments < ActiveRecord::Migration
  def change
    create_table :recruitments do |t|
      t.string :identity_number
      t.string :name
      t.string :place_of_birth
      t.datetime :date_of_birth
      t.integer :gender
      t.integer :religion
      t.string :phone
      t.string :address
      t.integer :office_id
      t.integer :branch_office_id
      t.integer :department_id
      t.integer :division_id
      t.integer :title_id
      t.integer :level_id
      t.integer :status_working_id
      t.datetime :date_application
      t.datetime :date_psikotest
      t.datetime :date_interview
      t.string :description
      t.boolean :is_bank_data, :default => false
      
      t.timestamps
    end
  end
end
