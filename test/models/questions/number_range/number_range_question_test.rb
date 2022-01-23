require 'test_helper'

class NumberRangeQuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			NumberRangeQuestion.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false,
				from: 1,
				to: 10,
				step: 1
			)
	end
	include AbstractClassTest
end
