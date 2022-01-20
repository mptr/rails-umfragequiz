require 'test_helper'

class TextQuestionTest < ActiveSupport::TestCase
  def setup
    @q =
      TextQuestion.new(
        description: 'TestQuestion',
        survey: Survey.first,
        optional: false
      )
  end
  
  # test the basic question fields of @q
  include QuestionTests
end
