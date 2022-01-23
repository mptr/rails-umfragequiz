require 'test_helper'

class LikertQuestionTest < ActiveSupport::TestCase
	def setup
		@q =
			LikertQuestion.new(
				description: 'TestQuestion',
				survey: Survey.first,
				optional: false,
				answer_options: %w[A B C D],
				questions: ['very', 'somewhat', 'not at all']
			)
	end

	include QuestionTests

	include RearrangeableQuestionTests

	test 'should have at least one question' do
		@q.questions = []
		assert_not @q.save, 'Saved with no questions'
		@q.questions = ['dont know']
		assert @q.save, 'Failed to save with one question'
	end

	test 'should have no empty question' do
		@q.questions = ['very', '', 'not at all']
		assert_not @q.save, 'Saved with empty question'
	end
end
