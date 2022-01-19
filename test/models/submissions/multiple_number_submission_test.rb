require "test_helper"

class MultipleNumberSubmissionTest < ActiveSupport::TestCase
  test "MultipleNumberSubmission validations" do
    s = MultipleNumberSubmission.new

    # tests answer presence
    assert_not s.save, "Saved MultipleNumberSubmission without answer"

    # tests if answer ist empty
    s.answer = []
    assert_not s.save, "Saved MultipleNumberSubmission with empty answer"

    # tests if valid answer is saveable
    s.answer = ["valid", "answer"]
    assert s.save, "Failed to save MultipleNumberSubmission with valid answer"
  end
end
