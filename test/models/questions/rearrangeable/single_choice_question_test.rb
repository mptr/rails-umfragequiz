require 'test_helper'

class SingleChoiceQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      SingleChoiceQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        answer_options: ["A", "B", "C", "D"]
      )
  end

  include QuestionTests

  include RearrangeableQuestionTests

  test 'should set up_to=1' do
    @q.up_to = 4
    @q.save
    assert_equal 1, @q.up_to, 'Failed to set up_to=1'
  end
end
