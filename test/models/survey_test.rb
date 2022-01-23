require 'test_helper'

class SurveyTest < ActiveSupport::TestCase
	def setup
		@survey =
			Survey.new(
				name: 'TestSurvey',
				user: User.first,
				from_date: DateTime.yesterday,
				to_date: DateTime.tomorrow
			)
	end

	test 'should validate survey name' do
		@survey.name = nil
		assert_not @survey.save, 'Saved survey without name'
		@survey.name = ''
		assert_not @survey.save, 'Saved survey with empty name'
		@survey.name = 'TestSurvey'
		assert @survey.save, 'Failed to save survey with valid name'

		survey2 = @survey.dup
		assert_not survey2.save, 'survey name not unique'
	end

	test 'should validate from&to date' do
		@survey.from_date = nil
		assert_not @survey.save, 'Saved survey without from_date'
		@survey.from_date = DateTime.yesterday

		@survey.to_date = nil
		assert_not @survey.save, 'Saved survey without to_date'
		@survey.to_date = DateTime.tomorrow

		@survey.to_date = DateTime.yesterday
		@survey.from_date = DateTime.tomorrow
		assert_not @survey.save, 'Saved survey with to_date before from_date'

		@survey.to_date = DateTime.tomorrow
		@survey.from_date = DateTime.yesterday
		assert @survey.save, 'Failed to save survey with valid dates'
	end

	test 'should have user associated' do
		@survey.user = nil
		assert_not @survey.save, 'Saved survey without user'
	end

	test 'should have no questions associated' do
		assert_equal 0,
		             @survey.questions.length,
		             'new Survey already has associated questions'
	end
end
