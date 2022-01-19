require "test_helper"

class StringSubmissionTest < ActiveSupport::TestCase
  test "StringSubmission validations" do
    s = StringSubmission.new

    # tests answer presence
    assert_not s.save, "Saved StringSubmission without answer"

    # tests if answer ist empty
    s.answer = ""
    assert_not s.save, "Saved StringSubmission with empty answer"

    # tests if valid answer is saveable
    s.answer = "Valid Answer"
    assert s.save, "Failed to save StringSubmission with valid answer"
  end
end
