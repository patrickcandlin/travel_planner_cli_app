require "require_all"
require "sinatra/activerecord"
require "pry"
require_all "./lib"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/travelapp.sqlite"
)

# CommandLineInterface.say_hi
binding.pry