require "test_helper"

class NpsQuestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @nps_question = nps_questions(:one)
  end

  test "should get index" do
    get nps_questions_url, as: :json
    assert_response :success
  end

  test "should create nps_question" do
    assert_difference('NpsQuestion.count') do
      post nps_questions_url, params: { nps_question: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show nps_question" do
    get nps_question_url(@nps_question), as: :json
    assert_response :success
  end

  test "should update nps_question" do
    patch nps_question_url(@nps_question), params: { nps_question: {  } }, as: :json
    assert_response 200
  end

  test "should destroy nps_question" do
    assert_difference('NpsQuestion.count', -1) do
      delete nps_question_url(@nps_question), as: :json
    end

    assert_response 204
  end
end
