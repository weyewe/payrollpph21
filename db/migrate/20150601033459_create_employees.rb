class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.integer :office_id
      t.integer :branch_office_id
      t.integer :department_id
      t.integer :division_id
      t.integer :title_id
      t.integer :level_id
      t.integer :status_working_id
      t.string :code
      t.string :full_name
      t.string :nick_name
      t.integer :enroll_id
      t.string :place_of_birth
      t.datetime :date_of_birth
      t.integer :gender
      t.integer :religion
      t.string :address
      t.string :no_jamsostek, :default => ""
      t.datetime :jamsostek_registered_date, :default => DateTime.now
      t.integer :bank_id
      t.string :bank_account
      t.string :bank_account_name
      t.datetime :start_working
      t.string :phone
      t.string :hp
      t.string :email
      t.integer :country
      t.string :identity_number
      t.boolean :is_not_active, :default => false
      t.datetime :not_active_at
      t.string :description

      t.timestamps
    end
  end
end
