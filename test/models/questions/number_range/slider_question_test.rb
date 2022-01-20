require 'test_helper'

class SliderQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      SliderQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        from: 1,
        to: 10,
        step: 1
      )
  end

  include QuestionTests

  include NumberRangeQuestionTests
end
