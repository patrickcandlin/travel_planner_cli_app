require "require_all"
require "sinatra/activerecord"
require "pry"
require_all "./lib"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/travelapp.sqlite"
)
<<<<<<< HEAD
CommandLineInterface.main_menu
# binding.pry
=======

# CommandLineInterface.say_hi
binding.pry
>>>>>>> ee74087338622ac420c2634376d170aa8dfcaf52
