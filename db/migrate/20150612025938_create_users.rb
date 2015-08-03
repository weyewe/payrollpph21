class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :office_id
      t.string :username
      t.string :password
      t.string :name
      
      t.timestamps
    end
  end
end
