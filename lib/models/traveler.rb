class Traveler < ActiveRecord::Base
    has_many :trips
    has_many :countrys, through: :trips

    def user_trips?(selection)
        until self.trips.ids.include?(selection.to_i) || selection.upcase == 'M' do
            puts "Sorry! That is not an ID for one of your trips." 
            puts "Please select one or your ID or type 'M' for MAIN MENU."  
            selection = gets.chomp
        end
        if selection.upcase == 'M'
            return CommandLineInterface.main_menu
        else
        Trip.find(selection.to_i)
        end
    end
end