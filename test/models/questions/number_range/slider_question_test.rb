require 'test_helper'

class SliderQuestionTest < NumberQuestionTest
  # just do same tests as in NumberQuestionTest
  # but with different class
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
end
