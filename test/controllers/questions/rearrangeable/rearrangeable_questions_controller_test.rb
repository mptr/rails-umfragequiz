require "test_helper"

class RearrangeableQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rearrangeable_question = rearrangeable_questions(:one)
  end

  test "should get index" do
    get rearrangeable_questions_url, as: :json
    assert_response :success
  end

  test "should create rearrangeable_question" do
    assert_difference('RearrangeableQuestion.count') do
      post rearrangeable_questions_url, params: { rearrangeable_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show rearrangeable_question" do
    get rearrangeable_question_url(@rearrangeable_question), as: :json
    assert_response :success
  end

  test "should update rearrangeable_question" do
    patch rearrangeable_question_url(@rearrangeable_question), params: { rearrangeable_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy rearrangeable_question" do
    assert_difference('RearrangeableQuestion.count', -1) do
      delete rearrangeable_question_url(@rearrangeable_question), as: :json
    end

    assert_response 204
  end
end
