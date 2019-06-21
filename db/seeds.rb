require 'rest-client'
require "json"


# response_string = RestClient.get('http://api.geonames.org/countryInfoJSON?2&lang=en&username=username')
# response_hash = JSON.parse(response_string)

# response_hash["geonames"].each do |country|
#     Country.create(countryName: country["countryName"], capital: country["capital"], currencyCode: country["currencyCode"], countryCode: country["countryCode"], population: country["population"])
# end

# Traveler.create(userName: "Patrick")
# Traveler.create(userName: "Dave")

Trip.create(budget: 1000, tripNotes: "see grandma", country_id: 5, traveler_id: 2)