require "pry"
class CommandLineInterface

  def self.welcome
    puts "Hi, welcome to <name of app>!
    If you're a returning user, enter '1'. If you're new, enter '2'."
    user_response = gets.chomp
    if user_response == "1"
      puts "Enter username"
      username = gets.chomp
      if Traveler.find_by(userName: username) == nil
        create_username
      else @current_user = Traveler.find_by(userName: username)
    elsif user_response == "2"
      puts "This feature in development. Check back soon!"
      exit
    else
      puts "WHAT ARE YOU DOING?! '1', or '2'!"
    end
  end
def.self.current_user
  puts "Please choose a username:"
  user_response = gets.chomp
  
end
  def self.main_menu
    puts "  What would you like to do?

    Type 'C' to CREATE a trip
    Type 'R' to REVIEW your trip(s)
    Type 'U' to UPDATE a trip
    Type 'D' to DELETE an existing trip
    Type 'Q' to QUIT

    Hit return after entering your selection"
    user_response = gets.chomp.upcase
      if user_response == "C"
        create_trip
      elsif user_response == 'R'
        review_trip
      elsif user_response == 'D'
        delete_trip
      elsif user_response == "Q"
        puts "See you soon!"
      elsif user_response == 'U'
        update_trip
      end
    end

    def self.create_trip
      puts "What's your budget?"
      user_budget = gets.chomp
      puts "...and your reason for traveling?"
      user_reason = gets.chomp
      puts "...and, which country are you traveling to?"
      country = gets.chomp
      country_traveling_to = Country.find_by(countryName: country)
      Trip.create(budget: user_budget, tripNotes: user_reason, traveler_id: @current_user.id, country_id: country_traveling_to.id)
      puts "Your trip has been saved!"
      puts
      main_menu
    end

    def self.delete_trip
      puts "Which trip would you like to delete?"
      @current_user.trips.each do |trip|
        puts "ID:#{trip.id}. #{trip.country.countryName}! Why? #{trip.tripNotes}. Budget: #{trip.budget}"
      end
      puts
      puts "please make your selection by ID number"
      user_selection = gets.chomp
      user_wants_to_delete = Trip.find(user_selection)
      user_wants_to_delete.delete
      puts "That trip is deleted."
      main_menu
    end

    def self.review_trip
      @current_user.trips.each do |trip|
        puts "You're going to #{trip.country.countryName}; you've budgeted #{trip.budget}. These are your notes: #{trip.tripNotes}"
      end
      puts
      puts
      sleep(3)
      # puts "'M' for Main Menu, or 'Q' to quit"
      # user_choice = gets.chomp.upcase
      # if user_choice == "M"
      #   main_menu
      # elsif user_choice == "Q"
      #   puts "See you soon!"
      # else
      #   puts "'M' for Main Menu, or 'Q' to quit"
      # end
      main_menu
    end

    def self.update_trip
      puts "Which trip would you like to update?"
      puts
      @current_user.trips.each do |trip|
        puts "ID:#{trip.id}. #{trip.country.countryName}! Why? #{trip.tripNotes}. Budget: #{trip.budget}"
      end
      puts "please make your selection by ID number"
      user_selection = gets.chomp
      user_wants_to_update = Trip.find(user_selection)
      puts "What would you like to update?
        Type 'D' for DESTINATION
        Type 'B' for BUDGET
        Type 'N' for NOTES"
      user_menu_selection = gets.chomp
      if user_menu_selection.upcase == 'D'
        puts "What would you like to update your destination to be?"
        user_destination_update = gets.chomp
        the_country_id= Country.find_by(countryName: user_destination_update).id
        user_wants_to_update.update(country_id: the_country_id)
        main_menu
      elsif user_menu_selection.upcase == 'B'
        puts "What would you like to update your budget to be?"
        user_budget_update = gets.chomp
        user_wants_to_update.update(budget: user_budget_update)
      elsif user_menu_selection.upcase == 'N'
        puts "What would you like to update your notes to be?"
        user_notes_update = gets.chomp
        user_wants_to_update.update(tripNotes: user_notes_update)
      end
      main_menu
    end

    def self.runner
      welcome
      main_menu
    end
  end
