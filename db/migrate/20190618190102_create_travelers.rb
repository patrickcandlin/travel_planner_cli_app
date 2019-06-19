class CreateTravelers < ActiveRecord::Migration[5.2]
  def change
    t.string :userName
  end
end
