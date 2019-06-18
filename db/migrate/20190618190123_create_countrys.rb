class CreateCountrys < ActiveRecord::Migration[5.2]
  def change 
    create_table :countries do |t|
      t.string :countryName
      t.string :capital
      t.string :currencyCode
      t.string :countryCode
      t.string :population
    end
  end
end
