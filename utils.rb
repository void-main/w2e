#!/usr/bin/env ruby

class Integer
	# padding int with "pad" to "width" length
	# For example:
	#   1.to_rjust_s 2, "0" => "01"
	# Especially useful when processing date strings
	def to_rjust_s width, pad
		self.to_s.rjust width, pad
	end
end

class Array
	def filter_with_tag tags
		tags.each do |tag|
			self.select! do |item|
				item["tags"].include? tag
			end
		end

		self
	end
end