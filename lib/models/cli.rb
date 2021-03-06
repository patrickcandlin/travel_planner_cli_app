require "pry"

class CommandLineInterface

  def self.welcome
    puts "
                                                          __!__
                                                      _____(_)_____
                                                                      ".colorize(:light_blue)
    puts "Hi, Welcome to Tripoggan!"
    puts "WMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW".colorize(:green)
    puts
    puts "If you're a returning user, enter '1'. If you're new, enter '2'."
    user_response = gets.chomp
    if user_response == "1"
      puts
      puts "Enter username"
      username = gets.chomp
      if Traveler.exists?(userName: username)
        @current_user = Traveler.find_by(userName: username)
      else
        create_username
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
    puts
    if Traveler.exists?(userName: user_response)
      puts
      puts "that name is already in use"
      welcome
    else
      @current_user = Traveler.create(userName: user_response)
      puts "Welcome, #{user_response}!"
      puts
    end
  end

  def self.main_menu
    puts
    puts "    What would you like to do?

    Type 'C' to CREATE a trip
    Type 'R' to REVIEW your trip(s)
    Type 'U' to UPDATE a trip
    Type 'D' to DELETE an existing trip
    Type 'I' to GET INFO about a country
    Type 'Q' to QUIT

    Hit return after entering your selection".colorize(:light_blue)
    user_response = gets.chomp.upcase
      if user_response == "C"
        create_trip
      elsif user_response == 'R'
        review_trip
      elsif user_response == 'D'
        delete_trip
      elsif user_response == "Q"
        puts
        puts "Happy Trails!"
        puts "WMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMWMW".colorize(:green)
        puts
      elsif user_response == 'U'
        update_trip
      elsif user_response == "I"
        get_country_info
      else
        puts "Type a 'C', 'R', 'U', 'R', 'D', 'I', or 'Q'."
        main_menu
      end

    end

    def self.budget_check(check_this)
      if check_this.to_f == 0.0
        puts "You haven't budgeted for this trip; add a budget via the UPDATE function"
        check_this = 0.00
      else
        check_this
      end
    end

    def self.create_trip
      puts
      puts "What's your budget?"
      user_budget = budget_check(gets.chomp)
      puts
      puts "...and your reason for traveling?"
      user_reason = gets.chomp
      puts
      puts "...and, which country are you traveling to?"
      country = gets.chomp.capitalize
      country_traveling_to = Country.real_country(country)
      Trip.create(budget: user_budget, tripNotes: user_reason, traveler_id: @current_user.id, country_id: country_traveling_to.id)
      puts
      puts "Your trip has been saved!".colorize(:green)
      puts
      main_menu
    end

    def self.delete_trip
      @current_user.trips.reload
      if @current_user.trips.empty?
        puts
        puts "You don't have any trips to delete."
        puts
        main_menu
      else
        puts
        puts "Which trip would you like to delete?"
        puts
        @current_user.trips.each do |trip|
          puts " ID:#{trip.id} ".red + " #{trip.country.countryName} ".black.on_light_yellow + " Why? #{trip.tripNotes}. Budget: #{trip.budget}"
          puts
        end
        puts
        puts "Please make your selection by" + " ID number".red
        puts
        puts "Or if you do not want to delete any trips. Please type 'M' for MAIN MENU"
      end
        user_selection = gets.chomp
      if user_selection.capitalize == 'M'
        main_menu
      else
        user_wants_to_delete = @current_user.user_trips?(user_selection)
        user_wants_to_delete.delete
        puts "That trip is deleted.".colorize(:red)
        main_menu
      end

    end

    def self.review_trip
      puts
      @current_user.trips.reload
      if @current_user.trips.empty?
        puts "You don't have any trips scheduled."
        puts
        main_menu
      else @current_user.trips.each do |trip|
        puts "You're going to " + " #{trip.country.countryName} ".black.on_light_yellow + "! You've budgeted #{sprintf("%.2f", trip.budget)}. These are your notes: #{trip.tripNotes}"
          if Getdata.get_rate(trip.country.countryName) == nil
            puts "Sorry, we don't currently have exchange rate information for that country."
            puts
          else
            puts "Your budget in #{trip.country.currencyCode}, #{trip.country.countryName}'s local currency, is #{sprintf("%.2f", Getdata.get_rate(trip.country.countryName) * trip.budget)}"
            puts
          end
        end
        puts
        main_menu
      end
    end

    def self.update_trip
      @current_user.trips.reload
      if @current_user.trips.empty?
        puts
        puts "You don't have any trips to update."
        puts
        main_menu
      else
        puts
        puts "Which trip would you like to update?"
        puts
        @current_user.trips.each do |trip|
          puts "ID:#{trip.id} ".colorize(:light_blue) + " #{trip.country.countryName} ".black.on_light_yellow + " Why? #{trip.tripNotes}. Budget: #{trip.budget}"
          puts
        end
        puts
        puts "Please make your selection by " + "ID number".colorize(:light_blue)
        user_selection = gets.chomp
        user_wants_to_update = @current_user.user_trips?(user_selection)
        puts
        puts "What would you like to update?

          Type " + "'D'".colorize(:light_blue) + " for DESTINATION
          Type " + "'B'".colorize(:light_blue) + " for BUDGET
          Type " + "'N'".colorize(:light_blue) + " for NOTES
          Type " + "'M'".colorize(:light_blue) + " for MAIN MENU"
        user_menu_selection = gets.chomp
        if user_menu_selection.upcase == 'D'
          puts "What would you like to update your destination to be?"
          user_destination_update = gets.chomp
          the_country_id = Country.real_country(user_destination_update.capitalize).id
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
        elsif user_menu_selection.upcase == 'M'
          main_menu

        else
          puts "Sorry, I did get that. Please type 'D', 'B', 'N', or 'M'."
          update_trip
        end
      end
    end

    def self.get_country_info
      puts
      puts "Which country would you like to know more about?"
      user_response = gets.chomp
      current_selection = Country.real_country(user_response.capitalize)
      puts
      puts "Great! Here's some basic info on " + " #{current_selection.countryName} ".black.on_light_yellow + ":

       Capital: #{current_selection.capital}
       Currency: #{current_selection.currencyCode}
       Population: #{current_selection.population.reverse.scan(/.{3}|.+/).join(",").reverse}"
      puts
      main_menu
    end

    def self.runner
      welcome
      # binding.pry
      main_menu
    end
end
