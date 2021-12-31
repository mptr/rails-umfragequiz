require "test_helper"

class QuestionTest < ActiveSupport::TestCase
  def setup
    @q = Question.new(description: "TestQuestion", survey: Survey.first, optional: false)
  end

  # test if Question class is marked abstract
  include AbstractClassTest
end

# define more question-tests for inheritance-leaf-nodes
module QuestionTests
  def test_should_have_description
    @q.description = nil
    assert_not @q.save, "Saved without description"

    @q.description = ""
    assert_not @q.save, "Saved with empty description"

    @q.description = "TestQuestion" + rand(10000).to_s
    assert @q.save!, "Failed to save with valid description"
  end

  def test_should_have_optional_flag
    @q.optional = nil
    assert_not @q.save, "Saved without optional"

    @q.optional = true
    assert @q.save!, "Failed to save with valid optional"

    @q2 = @q.dup
    @q2.optional = false
    assert @q.save!, "Failed to save with valid optional"
  end

  def test_should_have_survey_associated
    @q.survey = nil
    assert_not @q.save, "Saved without survey"
  end
end
