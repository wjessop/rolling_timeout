[![Build Status](https://travis-ci.org/wjessop/rolling_timeout.png)](https://travis-ci.org/wjessop/rolling_timeout)

# RollingTimeout

A timeout class with a rolling window. Call reset to reset the timer back to 0, stop and start do what you might expect.

## Installation

Add this line to your application's Gemfile:

		gem 'rolling_timeout'

And then execute:

		$ bundle

Or install it yourself as:

		$ gem install rolling_timeout

## Usage

````ruby
require 'rolling_timeout'

begin
	RollingTimeout.new(1) {|timer| # 1 second timeout
		sleep(0.9)
		timer.reset # Back to 1 second on the timeout clock
		sleep(0.9)
		timer.stop  # The timer is stopped, we can do what we want for as long as we want
		sleep(0.2)  # This would have taken us over the 1 second timeout if the timer was running
		timer.start # restart the timer
		sleep(100)  # This will now timeout quickly
	}
rescue Timeout::Error
	puts "Timed out"
end
````

## Requirements

Works with ruby 2.0, probably 1.9.3 too. 1.8.7 YMMV.

## Issues

It's probably not a very accurate (relatively speaking) timer. How the VM schedules the code after the timer thread wakes up will affect how long after the actual time limit expires that the code thread is stopped and an exception raised. Also, if the code finishes at the same time the timeout thread wakes up it's a race to return.

That said, this was accurate enough for my needs. If you need something more accurate please feel free to submit a patch.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## Author

* Will Jessop (will@willj.net)