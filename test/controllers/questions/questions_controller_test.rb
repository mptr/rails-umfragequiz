require "test_helper"

class QuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    #@question = questions(:TextQuestion1)
  end

  # Fragen unterschiedlicher Surveys dürfen nicht gleich sein
  test "should not get all questions" do
    s1 = surveys(:one)
    s2 = surveys(:two)

    get survey_url(s1) + "/questions", as: :json
    r1 = response.body
    get survey_url(s2) + "/questions", as: :json
    r2 = response.body

    assert_not_equal r1, r2
  end
end
### standard tests

#   test "should get index" do
#     get questions_url, as: :json
#     assert_response :success
#   end

#   test "should create question" do
#     assert_difference('Question.count') do
#       post questions_url, params: { question: { description: @question.description, optional: @question.optional, survey_id: @question.survey_id } }, as: :json
#     end

#     assert_response 201
#   end

#   test "should show question" do
#     get question_url(@question), as: :json
#     assert_response :success
#   end

#   test "should update question" do
#     patch question_url(@question), params: { question: { description: @question.description, optional: @question.optional, survey_id: @question.survey_id } }, as: :json
#     assert_response 200
#   end

#   test "should destroy question" do
#     assert_difference('Question.count', -1) do
#       delete question_url(@question), as: :json
#     end

#     assert_response 204
#   end
# end
