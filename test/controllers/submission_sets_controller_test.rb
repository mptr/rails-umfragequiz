require "test_helper"

class SubmissionSetsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @survey_owner = users(:one)
    @submission_set = @survey_owner.surveys.first.submission_sets.where.not(user_id:@survey_owner.id).first

    @submitter = @submission_set.user
    
    @other_user = User.where.not(id:@survey_owner.id).where.not(id:@submitter.id).first
  end

  # nur owner
  test "should get index" do
    s1 = surveys(:one)

    get survey_path(s1) + "/submission_sets", as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@submitter)}
    assert_response 403

    # get survey_url(s1) + "/submission_sets", as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@other_user)}
    # assert_response 403

    # get survey_url(s1) + "/submission_sets", as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@survey_owner)}
    # assert_response :success
  end

  # alle
  # test "should create submission_set" do
  #   assert_difference('SubmissionSet.count') do
  #     post submission_sets_url, params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@survey_owner)}
  #   end
  #   assert_response 201

  #   assert_difference('SubmissionSet.count') do
  #     post submission_sets_url, params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@submitter)}
  #   end
  #   assert_response 201

  #   assert_difference('SubmissionSet.count') do
  #     post submission_sets_url, params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@other_user)}
  #   end
  #   assert_response 201
  # end

  # owner und submitter
  # test "should show submission_set" do
  #   get submission_sets_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@other_user)}
  #   assert_response 403

  #   get submission_sets_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@submitter)}
  #   assert_response :success

  #   get submission_set_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@survey_owner)}
  #   assert_response :success
  # end

  # nur submitter
  # test "should update submission_set" do
  #   patch submission_set_url(@submission_set), params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@other_user)}
  #   assert_response 403

  #   patch submission_set_url(@submission_set), params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@survey_owner)}
  #   assert_response 403

  #   patch submission_set_url(@submission_set), params: { submission_set: { submittedAt: @submission_set.submittedAt, survey_id: @submission_set.survey_id, user_id: @submission_set.user_id } }, as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@submitter)}
  #   assert_response 200
  # end

  # owner und submitter
  # test "should destroy submission_set" do
  #   delete submission_set_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@other_user)}
  #   assert_response 403

  #   assert_difference('SubmissionSet.count', -1) do
  #     delete submission_set_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@submitter)}
  #   end
  #   assert_response 204

  #   assert_difference('SubmissionSet.count', -1) do
  #     delete submission_set_url(@submission_set), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@survey_owner)}
  #   end
  #   assert_response 204
  # end
end
