require "test_helper"

class TextSubmissionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @text_submission = text_submissions(:one)
  end

  test "should get index" do
    get text_submissions_url, as: :json
    assert_response :success
  end

  test "should create text_submission" do
    assert_difference('TextSubmission.count') do
      post text_submissions_url, params: { text_submission: { answer: @text_submission.answer, text_question_id: @text_submission.text_question_id } }, as: :json
    end

    assert_response 201
  end

  test "should show text_submission" do
    get text_submission_url(@text_submission), as: :json
    assert_response :success
  end

  test "should update text_submission" do
    patch text_submission_url(@text_submission), params: { text_submission: { answer: @text_submission.answer, text_question_id: @text_submission.text_question_id } }, as: :json
    assert_response 200
  end

  test "should destroy text_submission" do
    assert_difference('TextSubmission.count', -1) do
      delete text_submission_url(@text_submission), as: :json
    end

    assert_response 204
  end
end
