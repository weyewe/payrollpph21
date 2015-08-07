class CreateBpjsPercentages < ActiveRecord::Migration
  def change
    create_table :bpjs_percentages do |t|
      t.integer :office_id
      t.decimal :employee_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :office_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.integer :max_of_children
      
      t.timestamps
    end
  end
end
