<<<<<<< HEAD
class CommandLineInterface

  def self.welcome
    puts "Hi, welcome to <name of app>!
    If you're a returning user, enter '1'. If you're new, enter '2'."
    user_response = gets.chomp
    if user_response == "1"
      puts "Enter username"
      username = gets.chomp.downcase
      @current_user = Traveler.find_by(userName: username)
    elsif user_response == "2"
      puts "This feature coming soon!"
    else
      puts "WHAT ARE YOU DOING?! '1', or '2'!"
    end
  end

  def self.main_menu
    welcome

    puts "  What would you like to do?

    Type 'C' to CREATE a trip
    Type 'R' to REVIEW your trip(s)
    Type 'U' to UPDATE a trip
    Type 'D' to DELETE an existing trip
    Type 'Q' to QUIT

    Hit return after entering your selection"
    user_response = gets.chomp.upcase
    if user_response == 'R'
      @current_user.trips.each do |trip|
        puts "You're going to #{trip.country.countryName}; you've budgeted #{trip.budget}"
      end
    end
  end




end
=======

>>>>>>> ee74087338622ac420c2634376d170aa8dfcaf52
