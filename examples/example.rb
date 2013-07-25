$:.unshift File.join(File.basename(__FILE__), "../lib")
require 'rolling_timeout'

begin
	RollingTimeout.new(1) {|timer|
		sleep(0.5)
		puts "slept for 0.5 seconds"
		timer.reset
		sleep(0.5)
		puts "slept for 0.5 seconds"
		timer.reset
		sleep(0.5)
		puts "slept for 0.5 seconds"
		timer.reset
		sleep(0.5)
		puts "Slept for 0.5 seconds, 2 total, will now timeout."
		sleep(100)
	}
rescue Timeout::Error
	puts "Timed out"
end
