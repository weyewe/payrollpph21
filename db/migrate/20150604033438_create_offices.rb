class CreateOffices < ActiveRecord::Migration
  def change
    create_table :offices do |t|
      t.string :code
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :state
      t.integer :country
      t.string :postal_code
      t.string :phone
      t.string :fax
      t.string :website
      t.string :email
      t.string :npwp
      t.string :director
      t.string :npwp_director
    end
  end
end
