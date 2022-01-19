require "test_helper"

class NumberSubmissionTest < ActiveSupport::TestCase
  test "NumberSubmission validations" do
    s = NumberSubmission.new

    # tests answer presence
    assert_not s.save, "Saved NumberSubmission without answer"

    # tests if answer ist empty
    s.answer = ""
    assert_not s.save, "Saved NumberSubmission with empty answer"

    # tests if valid answer is saveable
    s.answer = 5
    assert s.save, "Failed to save NumberSubmission with valid answer"
  end
end
