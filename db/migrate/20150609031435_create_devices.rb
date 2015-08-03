class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :office_id
      t.string :ip_address
      t.integer :port
      t.string :name
      
      t.timestamps
    end
  end
end
