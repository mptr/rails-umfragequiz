require 'test_helper'

class NumberRangeQuestionTest < ActiveSupport::TestCase
  def setup
    @q = NumberRangeQuestion.new(
      description: 'TestQuestion',
      survey: Survey.first,
      optional: false,
      from: 1,
      to: 10,
      step: 1
    )
  end
  include AbstractClassTest
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
