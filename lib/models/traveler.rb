class Traveler < ActiveRecord::Base
    has_many :trips
    has_many :countrys, through: :trips
end