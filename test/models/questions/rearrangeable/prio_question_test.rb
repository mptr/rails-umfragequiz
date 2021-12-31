require 'test_helper'

class PrioQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      PrioQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        answer_options: ["A", "B", "C", "D"]
      )
  end

  include QuestionTests

  include RearrangeableQuestionTests
end
