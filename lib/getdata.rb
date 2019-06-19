require "pry"
require 'rest-client'
require "require_all"
require_all "./lib"

class Getdata

    def self.get_rate(user_country) #user enters a country and this returns a rate.
        url = "https://api.exchangeratesapi.io/latest?base=USD" #aip for up to date currency rates 
        @@data = RestClient.get(url) 
        @@response = JSON.parse(@@data) 
        code = Country.all.select{|country| country[:countryName] == user_country}.first[:currencyCode] #gets the currencyCode when given country
        @@response["rates"][code]
    end



end