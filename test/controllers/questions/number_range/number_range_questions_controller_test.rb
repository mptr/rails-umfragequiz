require "test_helper"

class NumberRangeQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @number_range_question = number_range_questions(:one)
  end

  test "should get index" do
    get number_range_questions_url, as: :json
    assert_response :success
  end

  test "should create number_range_question" do
    assert_difference('NumberRangeQuestion.count') do
      post number_range_questions_url, params: { number_range_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show number_range_question" do
    get number_range_question_url(@number_range_question), as: :json
    assert_response :success
  end

  test "should update number_range_question" do
    patch number_range_question_url(@number_range_question), params: { number_range_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy number_range_question" do
    assert_difference('NumberRangeQuestion.count', -1) do
      delete number_range_question_url(@number_range_question), as: :json
    end

    assert_response 204
  end
end
