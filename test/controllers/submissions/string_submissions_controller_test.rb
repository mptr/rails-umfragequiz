require "test_helper"

class StringSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @string_submission = string_submissions(:one)
  end

  test "should get index" do
    get string_submissions_url, as: :json
    assert_response :success
  end

  test "should create string_submission" do
    assert_difference('StringSubmission.count') do
      post string_submissions_url, params: { string_submission: { answer: @string_submission.answer, string_question_id: @string_submission.string_question_id } }, as: :json
    end

    assert_response 201
  end

  test "should show string_submission" do
    get string_submission_url(@string_submission), as: :json
    assert_response :success
  end

  test "should update string_submission" do
    patch string_submission_url(@string_submission), params: { string_submission: { answer: @string_submission.answer, string_question_id: @string_submission.string_question_id } }, as: :json
    assert_response 200
  end

  test "should destroy string_submission" do
    assert_difference('StringSubmission.count', -1) do
      delete string_submission_url(@string_submission), as: :json
    end

    assert_response 204
  end
end
