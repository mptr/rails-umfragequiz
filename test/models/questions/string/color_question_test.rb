require 'test_helper'

class ColorQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      ColorQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false
      )
  end

  # test the basic question fields of @q
  include QuestionTests
end
