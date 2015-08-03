class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.integer :employee_id
      t.datetime :received_at
      t.string :location
      t.string :no_certificate
      t.string :receiver
      t.boolean :is_returned, :default => false
      t.datetime :returned_at
      t.string :giver
      t.string :description
      t.boolean :is_deleted
      t.datetime :deleted_at
      
      t.timestamps
    end
  end
end
