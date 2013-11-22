#!/usr/bin/env ruby
# retrieve weather for us
require 'net/http'
require 'json'

class Weather
	BASE_URL = "http://api.openweathermap.org/data/2.5/weather?q"

	def initialize loc
		@url = "#{BASE_URL}=#{loc}"
	end

	def now
		puts "Fetching weather..."
		resp = Net::HTTP.get_response(URI.parse(@url))
		buffer = resp.body
		result = JSON.parse(buffer)
		weather_now = result["weather"][0]["main"].downcase
		puts "It's #{weather_now} now!"
		puts

		weather_now
	end

end