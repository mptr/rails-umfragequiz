require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  test "Question validations" do
    q = Question.new

    # tests question description presence
    assert_not q.save, "Saved Question without description"

    # tests if question description is empty
    q.description = ""
    assert_not q.save, "Saved Question with empty description"

    # tests if valid question description is saveable
    q.description = "Description of Question"
    assert q.save, "Failed to save Question with valid description"
  end

  # TODO: test optional field?
  # TODO: test question description uniqueness (within one survey)?
end
