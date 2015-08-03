class CreateBpjsInsurances < ActiveRecord::Migration
  def change
    create_table :bpjs_insurances do |t|
      t.integer :employee_id
      t.datetime :date
      t.integer :no
      t.float :premi
      t.string :description
      t.boolean :is_active, :default => true
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
