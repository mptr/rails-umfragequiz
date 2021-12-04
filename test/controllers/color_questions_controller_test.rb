require "test_helper"

class ColorQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @color_question = color_questions(:one)
  end

  test "should get index" do
    get color_questions_url, as: :json
    assert_response :success
  end

  test "should create color_question" do
    assert_difference('ColorQuestion.count') do
      post color_questions_url, params: { color_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show color_question" do
    get color_question_url(@color_question), as: :json
    assert_response :success
  end

  test "should update color_question" do
    patch color_question_url(@color_question), params: { color_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy color_question" do
    assert_difference('ColorQuestion.count', -1) do
      delete color_question_url(@color_question), as: :json
    end

    assert_response 204
  end
end
