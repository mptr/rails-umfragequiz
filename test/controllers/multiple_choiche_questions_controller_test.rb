require "test_helper"

class MultipleChoicheQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @multiple_choiche_question = multiple_choiche_questions(:one)
  end

  test "should get index" do
    get multiple_choiche_questions_url, as: :json
    assert_response :success
  end

  test "should create multiple_choiche_question" do
    assert_difference('MultipleChoicheQuestion.count') do
      post multiple_choiche_questions_url, params: { multiple_choiche_question: { upTo: @multiple_choiche_question.upTo } }, as: :json
    end

    assert_response 201
  end

  test "should show multiple_choiche_question" do
    get multiple_choiche_question_url(@multiple_choiche_question), as: :json
    assert_response :success
  end

  test "should update multiple_choiche_question" do
    patch multiple_choiche_question_url(@multiple_choiche_question), params: { multiple_choiche_question: { upTo: @multiple_choiche_question.upTo } }, as: :json
    assert_response 200
  end

  test "should destroy multiple_choiche_question" do
    assert_difference('MultipleChoicheQuestion.count', -1) do
      delete multiple_choiche_question_url(@multiple_choiche_question), as: :json
    end

    assert_response 204
  end
end
