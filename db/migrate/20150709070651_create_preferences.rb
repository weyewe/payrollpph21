class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :office_id
      t.float :ot_divider
      t.float :biaya_jabatan_percentage
      t.float :biaya_jabatan_max
      t.float :pph_non_npwp_percentage
      t.float :dpp_percentage
      t.integer :pph21_id
      
      t.timestamps
    end
  end
end
