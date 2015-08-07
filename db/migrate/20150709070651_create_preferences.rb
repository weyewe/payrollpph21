class CreatePreferences < ActiveRecord::Migration
  def change
    create_table :preferences do |t|
      t.integer :office_id
      t.decimal :ot_divider,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :biaya_jabatan_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :biaya_jabatan_max,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :pph_non_npwp_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.decimal :dpp_percentage,  :default => 0,  :precision => 14, :scale => 2
      t.integer :pph21_id
      
      t.timestamps
    end
  end
end
