require 'test_helper'

class MultipleChoiceQuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			MultipleChoiceQuestion.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false,
				answer_options: %w[A B C D]
			)
	end

	include QuestionTests

	include RearrangeableQuestionTests

	test 'should not save with up_to < 0' do
		@q.up_to = -1
		assert_not @q.save, 'Saved with up_to < 0'
	end
end
