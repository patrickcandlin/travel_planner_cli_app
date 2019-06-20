class Country < ActiveRecord::Base
    has_many :trips
    has_many :travelers, through: :trips

    def real_country(country)
        until Country.exists?(countryName: country) do
          puts "Sorry I do not recognize that country. Please check your spelling."
          country = gets.chomp
        end
        Country.find_by(countryName: country)
    end
end