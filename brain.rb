#!/usr/bin/env ruby
# Think, think, think, what shall we eat?
require 'json'

require './weather'
require './inner_date'
require './utils'

class Brain
	attr_accessor :data
	attr_accessor :conf

	def initialize
		@conf = JSON.parse(IO.read("config.json"))
		@data = JSON.parse(IO.read("data.json"))
	end

	def give_me_one
		puts "Choosing from the following candidates: "
		list = candidates
		list.each do |item|
			puts info_of item
		end

		puts "\nAnd the result goes to..."
		puts info_of list.sample
		puts "Tada!"
		puts
	end

	def candidates
		candidates = @data["place-list"]
		tags = tags_for_now
		candidates.filter_with_tag tags
	end

	def tags_for_now
		result = []

		cons = @data["constaints"]
		cons.each do |con|
			if con["type"] == "Calendar"
				id = InnerDate.new Time.now
				code = id.partial_code
				tag = con["value"][code] || con["value"]["#{code[0]}*"] # support wild discard like *
				if tag
					result << tag
					break
				end
			elsif con["type"] == "Whether"
				weather = Weather.new @conf["loc"]
				tag = con["value"][weather.now]
				result << tag if tag
			end
		end

		result
	end

	def info_of item
		"#{item["name"]}\n#{item["tel"] if item.has_key? "tel"}"
	end
end