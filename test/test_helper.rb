ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'

class ActiveSupport::TestCase
	# Run tests in parallel with specified workers
	parallelize(workers: :number_of_processors)

	# Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
	fixtures :all

	# Add more helper methods to be used by all tests here...
	def generate_token_for(u)
		"Bearer magically-generated #{u.email} #{u.username}"
	end
end

# a test case that checks if saving an instance of an abstract class is prevented
# requires @q to be defined as the question to be tested
module AbstractClassTest
	def test_should_be_abstract_class
		assert_not @q.save, 'Saved instance of abstract class'
	end
end

module RearrangeableQuestionTests
	def test_no_empty_answer_option
		@q.answer_options = ['A', '', 'C', 'D']
		assert_not @q.save, 'Saved with empty answer_option'
	end

	def test_should_have_at_least_one_answer_option
		@q.answer_options = []
		assert_not @q.save, 'Saved without answer_options'
		@q.answer_options.append('TestAnswerOption')
		assert @q.save, 'Failed to save with an answer_option'
	end

	def test_should_keep_order_of_answer_options
		@q.answer_options = []
		@q.answer_options.append('b')
		@q.answer_options.append('a')
		assert @q.save, 'Failed to save with two answer_options'
		assert_equal %w[b a],
		             @q.answer_options,
		             'Failed to keep order of answer_options'
		@q.answer_options.sort
		assert @q.save, 'Failed to save with two reordered answer_options'
		q_restore = RearrangeableQuestion.last
		assert_equal %w[a b],
					  q_restore.answer_options,
		             'Failed to keep order of answer_options after reorder'
	end
end

# define more question-tests for inheritance-leaf-nodes
module QuestionTests
	def test_should_have_description
		@q.description = nil
		assert_not @q.save, 'Saved without description'

		@q.description = ''
		assert_not @q.save, 'Saved with empty description'

		@q.description = 'TestQuestion' + rand(10_000).to_s
		assert @q.save!, 'Failed to save with valid description'
	end

	def test_should_have_optional_flag
		@q.optional = nil
		assert_not @q.save, 'Saved without optional'

		@q.optional = true
		assert @q.save!, 'Failed to save with valid optional'

		@q2 = @q.dup
		@q2.optional = false
		assert @q.save!, 'Failed to save with valid optional'
	end

	def test_should_have_survey_associated
		@q.survey = nil
		assert_not @q.save, 'Saved without survey'
	end
end

module NumberRangeQuestionTests
	def test_should_set_step_default
		@q.step = nil
		assert @q.save, 'Failed to save, did not set step=1'
		assert_equal 1, @q.step, 'Failed to set step=1 after save'
	end

	def test_should_not_save_without_from_and_to
		@q.from = nil
		@q.to = nil
		assert_not @q.save, 'Saved without from&to'

		@q.from = 1
		@q.to = nil
		assert_not @q.save, 'Saved without to'

		@q.to = 10
		@q.from = nil
		assert_not @q.save, 'Saved without from'
	end
end
