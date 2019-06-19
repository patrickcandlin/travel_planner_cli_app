class CreateTripsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.float :budget
      t.text :tripNotes
      t.index []
      t.index []
    end
  end
end
