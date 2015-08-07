class CreateBpjsInsurances < ActiveRecord::Migration
  def change
    create_table :bpjs_insurances do |t|
      t.integer :employee_id
      t.datetime :date
      t.string :no
      t.decimal :premi,  :default => 0,  :precision => 14, :scale => 2
      t.string :description
      t.boolean :is_active, :default => true
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
