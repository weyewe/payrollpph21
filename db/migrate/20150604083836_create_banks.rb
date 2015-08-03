class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.string :description
      
      t.timestamps
    end
  end
end
