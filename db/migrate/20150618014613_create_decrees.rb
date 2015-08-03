class CreateDecrees < ActiveRecord::Migration
  def change
    create_table :decrees do |t|
      t.string :no
      t.datetime :date
      t.integer :employee_id
      t.integer :office_id
      t.integer :branch_office_id
      t.integer :department_id
      t.integer :division_id
      t.integer :title_id
      t.integer :sk_type
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
