class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.integer :employee_id
      t.datetime :start_date
      t.datetime :end_date
      t.string :destination
      t.string :description
      t.boolean :is_deleted, :default => false
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
