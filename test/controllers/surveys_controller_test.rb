require 'test_helper'

class SurveysControllerTest < ActionDispatch::IntegrationTest
	setup do
		@owner = users(:one)
		@not_owner = users(:two)
		@survey = @owner.surveys.sample
	end

	# alle
	test 'should get index' do
		get surveys_url,
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@not_owner)
		    }
		assert_response :success

		get surveys_url,
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@owner)
		    }
		assert_response :success
	end

	# alle
	test 'should create survey' do
		assert_difference('Survey.count') do
			post surveys_url_with_user(@owner),
			     params: {
					survey: {
						name: @survey.name + " next",
						user_id: @survey.user_id,
						from_date: DateTime.yesterday,
						to_date: DateTime.tomorrow,
					},
					questions: [
							{type: "TextQuestion", description: "Testquestion01", optional: false},
					]
			     },
			     as: :json,
			     headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@owner)
			     }
				 assert_response 201
				end
	end

	# owner und submitter
	test 'should show survey' do
		get survey_url(@survey),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@not_owner)
		    }
		assert_response :success

		get survey_url(@survey),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@owner)
		    }
		assert_response :success
	end

	# nur owner
	test 'only owner should update survey' do
		patch survey_url(@survey),
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@not_owner)
		      },
		      params: {
				survey: {
					name: @survey.name,
					user_id: @survey.user_id
				}
		      }
		assert_response 403

		patch survey_url(@survey),
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@owner)
		      },
		      params: {
				survey: {
					name: @survey.name,
					user_id: @survey.user_id
				}
		      }
		assert_response :success
	end

	# nur owner
	test 'only owner should destroy survey' do
		delete survey_url(@survey),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@not_owner)
		       }
		assert_response 403

		assert_difference('Survey.count', -1) do
			delete survey_url(@survey),
			       as: :json,
			       headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@owner)
			       }
		end
		assert_response :success
	end
end
