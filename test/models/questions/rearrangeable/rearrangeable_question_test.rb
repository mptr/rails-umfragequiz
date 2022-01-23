require 'test_helper'

class RearrangeableQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      RearrangeableQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false,
        answer_options: ["A", "B", "C", "D"]
      )
  end
  include AbstractClassTest
end

