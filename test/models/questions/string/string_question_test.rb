require 'test_helper'

class StringQuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			StringQuestion.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false
			)
	end

	# only test if @q class is abstract
	include AbstractClassTest
end
