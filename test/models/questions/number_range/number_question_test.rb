require 'test_helper'

class NumberQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      NumberQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        from: 1,
        to: 10,
        step: 1
      )
  end

  include QuestionTests

  test 'should set step default' do
    @q.step = nil
    assert @q.save, 'Failed to save, did not set step=1'
    assert_equal 1, @q.step, 'Failed to set step=1 after save'
  end

  test 'should not save without from&to' do
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
