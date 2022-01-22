require "test_helper"

class SurveysControllerTest < ActionDispatch::IntegrationTest
  setup do
    @owner = users(:one)
    @not_owner = users(:two)
    @survey = @owner.surveys.first
  end

  # user darf: survey erstellen, verändern (submitten)
  # owner darf: lesen, löschen

  # test "should get index" do
  #   get surveys_url, as: :json
  #   assert_response :success
  # end

  # test "should create survey" do
  #   assert_difference('Survey.count') do
  #     post surveys_url, params: { survey: { fromDate: @survey.fromDate, name: @survey.name, toDate: @survey.toDate, user_id: @survey.user_id } }, as: :json
  #   end

  #   assert_response 201
  # end

  # test "should show survey" do
  #   get survey_url(@survey), as: :json
  #   assert_response :success
  # end

  # test "should update survey" do
  #   patch survey_url(@survey), params: { survey: { fromDate: @survey.fromDate, name: @survey.name, toDate: @survey.toDate, user_id: @survey.user_id } }, as: :json
  #   assert_response 200
  # end

  # test "should destroy survey" do
  #   assert_difference('Survey.count', -1) do
  #     delete survey_url(@survey), as: :json
  #   end

  #   assert_response 204
  # end

  # löschen mit Token, aber nicht owner => X
  # löschen mit Token und owner => success
  
  # user.email == requester_email?
  test "owner should delete survey" do
    delete survey_url(@survey), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@not_owner)}
    assert_response 403
    
    delete survey_url(@survey), as: :json, headers:{"HTTP_AUTHORIZATION" => generate_token_for(@owner)}
    assert_response :success
  end
end
