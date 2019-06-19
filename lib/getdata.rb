require "pry"
require 'rest-client'
require "require_all"
require_all "./lib"

class Getdata

    def self.retrieve_data
        url = "https://api.exchangeratesapi.io/latest?base=USD" #Public aip for up to date currency rates 
        @data = RestClient.get(url) 
        @response = JSON.parse(@data) 
    end

    def self.get_rate(user_country) #user enters a country and an exchange rate is returned.
        
        self.retrieve_data #gets the api hash for USD base
        
        country_hash =  Country.all.select do |country| #gets country hash when provided country
                            country[:countryName] == user_country
                        end 
        
        code = code.first[:currencyCode] #gets the currencyCode when given country_hash
        
        @response["rates"][code] #takes the API hash and returns the exchange rate.
    end



end