require "test_helper"

class RearrangeableQuestionTest < ActiveSupport::TestCase
  test "RearrangeableQuestion validations" do
    q = RearrangeableQuestion.new

    # tests answer presence
    assert_not q.save, "Saved RearrangeableQuestion without answer_options"

    # tests if answer ist empty
    q.answer_options = []
    assert_not q.save, "Saved RearrangeableQuestion with empty answer_options"

    # tests if valid answer is saveable
    q.answer_options = ["option1", "option2"]
    assert q.save, "Failed to save RearrangeableQuestion with valid answer_options"
  end
end
