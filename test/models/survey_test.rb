require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "Survey validations" do
	s = Survey.new

	# tests survey name presence
	assert_not s.save, "Saved survey without name"

	# tests if survey name is empty
	s.name = ""
	assert_not s.save, "Saved survey with empty name"

	# tests if valid survey name is saveable
	s.name = "Survey1"
	assert s.save, "Failed to save survey with valid name"

	# tests survey name uniqueness
	s2 = Survey.new
	s2.name = s.name
	assert_not s2.save, "Survey name is not unique but duplicate"
  end

  test "SubmissionSet association" do
		s = Survey.new
		s.name = "Survey01"

		assert_equal 0, u.submission_sets.length, "new Survey already has associated SubmissionSets"
	end

  test "Question association" do
	s = Survey.new
		s.name = "Survey01"

	assert_equal 0, u.questions.length, "new Survey already has associated Questions"
  end

  # user association test needed?
  # from_date and to_date test needed?
  # survey has as many questions as submissions?
end
