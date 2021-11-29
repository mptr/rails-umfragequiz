require "test_helper"

class SubmissionSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @submission_set = submission_sets(:one)
  end

  test "should get index" do
    get submission_sets_url, as: :json
    assert_response :success
  end

  test "should create submission_set" do
    assert_difference('SubmissionSet.count') do
      post submission_sets_url, params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show submission_set" do
    get submission_set_url(@submission_set), as: :json
    assert_response :success
  end

  test "should update submission_set" do
    patch submission_set_url(@submission_set), params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy submission_set" do
    assert_difference('SubmissionSet.count', -1) do
      delete submission_set_url(@submission_set), as: :json
    end

    assert_response 204
  end
end
