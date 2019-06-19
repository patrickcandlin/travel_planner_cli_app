class CreateTravelersTable < ActiveRecord::Migration[5.2]
  def change 
    create_table :travelers do |t|
      t.string :userName
    end
  end
end

