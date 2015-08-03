class CreateBpjsPercentages < ActiveRecord::Migration
  def change
    create_table :bpjs_percentages do |t|
      t.integer :office_id
      t.float :employee_percentage
      t.float :office_percentage
      t.integer :max_of_children
      
      t.timestamps
    end
  end
end
