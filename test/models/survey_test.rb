require "test_helper"

class SurveyTest < ActiveSupport::TestCase
  test "Survey validations" do
    s = Survey.new
    assert_not s.save, "Saved survey without name"
    s.name = ""
    assert_not s.save, "Saved survey with empty name"
  end
end
