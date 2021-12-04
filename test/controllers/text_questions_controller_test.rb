require "test_helper"

class TextQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_question = text_questions(:one)
  end

  test "should get index" do
    get text_questions_url, as: :json
    assert_response :success
  end

  test "should create text_question" do
    assert_difference('TextQuestion.count') do
      post text_questions_url, params: { text_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show text_question" do
    get text_question_url(@text_question), as: :json
    assert_response :success
  end

  test "should update text_question" do
    patch text_question_url(@text_question), params: { text_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy text_question" do
    assert_difference('TextQuestion.count', -1) do
      delete text_question_url(@text_question), as: :json
    end

    assert_response 204
  end
end
