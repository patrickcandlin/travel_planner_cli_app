require "pry"
class CommandLineInterface

  def self.welcome
    puts
    puts "Hi, welcome to Tripoggan!
    If you're a returning user, enter '1'. If you're new, enter '2'."
    user_response = gets.chomp
    if user_response == "1"
      puts "Enter username"
      username = gets.chomp
      if Traveler.exists?(userName: username)
        @current_user = Traveler.find_by(userName: username)
      else create_username
      
      end
    elsif user_response == "2"
      create_username
    else
      welcome_invalid
    end
  end
  
  def self.welcome_invalid
    puts "WHAT ARE YOU DOING?! '1', or '2'!"
    welcome
  end

  def self.create_username
    puts "Please choose a username:"
    user_response = gets.chomp
    if Traveler.exists?(userName: user_response)  
      puts "that name is already in use" 
      welcome 
    else Traveler.create(userName: user_response)
    end
  end

  def self.main_menu
    puts "  What would you like to do?

    Type 'C' to CREATE a trip
    Type 'R' to REVIEW your trip(s)
    Type 'U' to UPDATE a trip
    Type 'D' to DELETE an existing trip
    Type 'I' to GET INFO about a country
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
        puts
        puts "See you soon!"
        puts
      elsif user_response == 'U'
        update_trip
      elsif user_response == "I"
        get_country_info
      end
  end
    def self.create_trip
      puts "What's your budget?"
      user_budget = gets.chomp
      puts "...and your reason for traveling?"
      user_reason = gets.chomp
      puts "...and, which country are you traveling to?"
      country = gets.chomp
      country_traveling_to = Country.real_country(country)#Country.find_by(countryName: country)
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
      @current_user = Traveler.find_by(userName: @current_user.userName)
        if @current_user.trips.empty?
          puts "You don't have any trips scheduled."
        else @current_user.trips.each do |trip|
          puts "You're going to #{trip.country.countryName}; you've budgeted #{trip.budget}. These are your notes: #{trip.tripNotes}"
          puts "Your budget in #{trip.country.currencyCode}, #{trip.country.countryName}'s local currency, is #{sprintf("%.2f", Getdata.get_rate(trip.country.countryName) * trip.budget)}"
        end
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
        main_menu
      elsif user_menu_selection.upcase == 'N'
        puts "What would you like to update your notes to be?"
        user_notes_update = gets.chomp
        user_wants_to_update.update(tripNotes: user_notes_update)
        main_menu
      end
      main_menu
    end

    def self.get_country_info
      puts "Which country would you like to know more about?"
      user_response = gets.chomp.capitalize
      current_selection = Country.find_by(countryName: user_response)
      puts "Great! Here's some basic information about #{current_selection.countryName}:
      Capital: #{current_selection.capital}
      Currency: #{current_selection.currencyCode}
      Population: #{current_selection.population}"
      puts
      main_menu
    end

    def self.runner
      welcome
      # binding.pry
      main_menu
    end
end