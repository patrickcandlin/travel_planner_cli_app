require "require_all"
require "sinatra/activerecord"
require "pry"
require "colorize"
require_all "./lib"

ActiveRecord::Base.establish_connection(
    :adapter => "sqlite3",
    :database => "db/travelapp.sqlite"
)

ActiveRecord::Base.logger = nil

CommandLineInterface.runner
# binding.pry
