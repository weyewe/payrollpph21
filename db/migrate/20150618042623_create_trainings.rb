class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.integer :office_id
      t.string :subject
      t.datetime :start_date
      t.datetime :end_date
      t.string :trainer
      t.string :location
      t.string :description
      
      t.timestamps
    end
  end
end
