require "test_helper"

class NumberRangeQuestionTest < ActiveSupport::TestCase
  test "NumberRangeQuestion description validations" do
    q = NumberRangeQuestion.new
    q.from = 1
    q.to = 5

    # tests question description presence
    assert_not q.save, "Saved NumberRangeQuestion without description"

    # tests if question description is empty
    q.description = ""
    assert_not q.save, "Saved NumberRangeQuestion with empty description"

    # tests if valid question description is saveable
    q.description = "Description of Question"
    assert q.save, "Failed to save NumberRangeQuestion with valid description"
  end

  test "NumberRangeQuestion from validations" do
    q = NumberRangeQuestion.new
    q.description = "Hello World"
    q.to = 5

    # tests from presence
    assert_not q.save, "Saved NumberRangeQuestion without from"

    # tests if from is empty
    q.from = nil
    assert_not q.save, "Saved NumberRangeQuestion with empty from"

    # tests if valid from is saveable
    q.from = 1
    assert q.save, "Failed to save NumberRangeQuestion with valid from"
  end

  test "NumberRangeQuestion to validations" do
    q = NumberRangeQuestion.new
    q.description = "Hello World"
    q.from = 1

    # tests to presence
    assert_not q.save, "Saved NumberRangeQuestion without to"

    # tests if to is empty
    q.to = nil
    assert_not q.save, "Saved NumberRangeQuestion with empty to"

    # tests if valid to is saveable
    q.to = 10
    assert q.save, "Failed to save NumberRangeQuestion with valid to"
  end

  test "NumberRangeQuestion step validations" do
    q = NumberRangeQuestion.new
    q.description = "Hello World"
    q.from = 1
    q.to = 10

    # tests step presence
    assert_not q.save, "Saved NumberRangeQuestion without step"

    # tests if step is empty
    q.step = nil
    assert_not q.save, "Saved NumberRangeQuestion with empty step"

    # tests if valid step is saveable
    q.step = 5
    assert q.save, "Failed to save NumberRangeQuestion with valid step"
  end
end
