class CreateTripsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.float :budget
      t.text :tripNotes
      t.references :traveler, foreign_key: true
      t.references :country, foreign_key: true
    end
  end
end
