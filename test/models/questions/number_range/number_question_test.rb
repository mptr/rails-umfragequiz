require 'test_helper'

class NumberQuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			NumberQuestion.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false,
				from: 1,
				to: 10,
				step: 1
			)
	end

	include QuestionTests

	include NumberRangeQuestionTests
end
