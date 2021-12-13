require "test_helper"

class PrioQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @prio_question = prio_questions(:one)
  end

  test "should get index" do
    get prio_questions_url, as: :json
    assert_response :success
  end

  test "should create prio_question" do
    assert_difference('PrioQuestion.count') do
      post prio_questions_url, params: { prio_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show prio_question" do
    get prio_question_url(@prio_question), as: :json
    assert_response :success
  end

  test "should update prio_question" do
    patch prio_question_url(@prio_question), params: { prio_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy prio_question" do
    assert_difference('PrioQuestion.count', -1) do
      delete prio_question_url(@prio_question), as: :json
    end

    assert_response 204
  end
end
