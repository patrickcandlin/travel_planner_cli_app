class Traveler < ActiveRecord::Base
    has_many :trips
    has_many :countrys, through: :trips

    def user_trips?(selection)
        until self.trips.ids.include?(selection.to_i) do
            puts "Sorry! That is not an ID for one of your trips." 
            selection = gets.chomp
        end
     
        Trip.find(selection.to_i)
    end
end