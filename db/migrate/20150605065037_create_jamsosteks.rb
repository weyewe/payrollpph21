class CreateJamsosteks < ActiveRecord::Migration
  def change
    create_table :jamsosteks do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.float :jkk_percentage
      t.float :jkm_percentage
      t.float :jht_employee_percentage
      t.float :jht_office_percentage
      
      t.timestamps
    end
  end
end
