require "test_helper"

class SliderQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @slider_question = slider_questions(:one)
  end

  test "should get index" do
    get slider_questions_url, as: :json
    assert_response :success
  end

  test "should create slider_question" do
    assert_difference('SliderQuestion.count') do
      post slider_questions_url, params: { slider_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show slider_question" do
    get slider_question_url(@slider_question), as: :json
    assert_response :success
  end

  test "should update slider_question" do
    patch slider_question_url(@slider_question), params: { slider_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy slider_question" do
    assert_difference('SliderQuestion.count', -1) do
      delete slider_question_url(@slider_question), as: :json
    end

    assert_response 204
  end
end
