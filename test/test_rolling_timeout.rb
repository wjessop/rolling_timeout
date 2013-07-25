require 'minitest_helper'

class TestRollingTimeout < MiniTest::Unit::TestCase
	def test_that_it_has_a_version_number
		refute_nil ::RollingTimeout::VERSION
	end

	def test_it_times_out
		assert_raises(Timeout::Error) {
			RollingTimeout.new(0.001) {|timer|
				sleep(0.002)
			}
		}
	end

	def test_it_completes_with_no_timeout_when_code_completes_within_time_limit
		marker = false
		RollingTimeout.new(0.001) {|timer|
			marker = true
		}
		assert(marker)
	end

	def test_it_rolls_the_timeout_window
		marker = false
    RollingTimeout.new(0.003) {|timer|
			sleep(0.002)
			timer.reset
			sleep(0.002)
			# Now outside the original timeout window
			marker = true
		}
		assert(marker)
	end

	def test_timer_stop
		marker = false
		RollingTimeout.new(0.001) {|timer|
			timer.stop
			sleep(0.002)
			# Now outside the original timeout window
			timer.start
			marker = true
		}
		assert(marker)
	end

	def test_timer_start
		assert_raises(Timeout::Error) {
			RollingTimeout.new(0.001) {|timer|
				timer.stop
				timer.start
				sleep(0.002)
			}
		}
	end
end
