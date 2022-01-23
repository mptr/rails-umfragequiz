require 'test_helper'

class QuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			Question.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false
			)
	end

	# test if Question class is marked abstract
	include AbstractClassTest
end
