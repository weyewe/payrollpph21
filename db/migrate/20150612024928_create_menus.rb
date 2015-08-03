class CreateMenus < ActiveRecord::Migration
  def change
    create_table :menus do |t|
      t.string :code
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
