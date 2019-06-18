class Country < ActiveRecord::Base
    has_many :trips
    has_many :travelers, through: :trips
end