#!/usr/bin/env ruby
# Generates inner date code for today
require 'active_support/time'
require './utils'

class InnerDate
	def initialize t
		@time = t
	end

	# code including date
	def full_code
		"#{@time.year}#{@time.month.to_rjust_s 2, "0"}#{@time.day.to_rjust_s 2, "0"}#{self.partial_code}"
	end

	# code for weekday-hour only
	def partial_code
		"#{@time.wday}#{@time.hour / 12}"
	end

	def last_full_code
		old_time = @time
		@time = @time - 12.hours
		result = full_code
		@time = old_time
		result
	end
end