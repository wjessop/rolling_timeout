require "rolling_timeout/version"
require 'timeout'
require 'thread'
 
class RollingTimeout
	def initialize(time_in_seconds, &block)
		@time_in_seconds = time_in_seconds
		start
		@timed_out = false
		@code_thread = Thread.new{ yield self }
		@code_thread.join
		@timer_thread.join if @timed_out

	end

	def reset
		stop
		start
	end

	def stop
		@timer_thread.kill
	end

	def start
		@timer_thread = new_timer_thread
	end

	private

	def new_timer_thread
		Thread.new {
			sleep(@time_in_seconds)
			@timed_out = true
			@code_thread.kill
			raise Timeout::Error
		}
	end
end
