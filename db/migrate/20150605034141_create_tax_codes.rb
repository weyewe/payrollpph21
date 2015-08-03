class CreateTaxCodes < ActiveRecord::Migration
  def change
    create_table :tax_codes do |t|
      t.integer :office_id
      t.string :code
      t.string :name
      t.boolean :is_final, :default => false
      t.string :description
      
      t.timestamps
    end
  end
end
