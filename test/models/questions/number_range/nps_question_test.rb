require 'test_helper'
require_relative '../question_test'
require_relative 'number_range_question_test'

class NpsQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      NpsQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false
      )
  end

  include QuestionTests

  include NumberRangeQuestionTests

  test 'should always set defaults' do
    # set some invalid from&to&step values
    @q.from = nil
    @q.to = 12
    @q.step = 0
    assert @q.save, 'Failed to save, did not override from&to&step values'
    assert_equal 1, @q.from, 'Failed to override from value'
    assert_equal 10, @q.to, 'Failed to override to value'
    assert_equal 1, @q.step, 'Failed to override step value'
  end
end
