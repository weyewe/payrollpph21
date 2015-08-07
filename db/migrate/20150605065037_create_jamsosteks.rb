class CreateJamsosteks < ActiveRecord::Migration
  def change
    create_table :jamsosteks do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.decimal :jkk_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jkm_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jht_employee_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jht_office_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jp_employee_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jp_office_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :jp_maximum_salary, :default => 0,  :precision => 14, :scale => 2
      
      t.timestamps
    end
  end
end
