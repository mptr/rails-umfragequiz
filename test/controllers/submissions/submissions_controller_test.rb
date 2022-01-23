require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@survey_owner = users(:one)
		@submission =
			@survey_owner
				.surveys
				.first
				.submission_sets
				.first
				.submissions
				.where.not(user_id: @survey_owner.id)
				.first

		@submitter = @submission_set.user

		@other_user =
			User
				.where.not(id: @survey_owner.id)
				.where.not(id: @submitter.id)
				.first
	end

	# survey_owner und submitter
	test 'should get index' do
		get submissions_url,
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		    }
		assert_response 403

		get submissions_url,
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success

		get submissions_url,
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		    }
		assert_response :success
	end

	# alle
	test 'should create submission' do
		assert_difference('Submission.count') do
			post submissions_url,
			     params: {
					submission: {
						question_id: @submission.question_id,
						submission_set_id: @submission.submission_set_id
					}
			     },
			     as: :json,
			     headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
			     }
		end
		assert_response 201

		assert_difference('Submission.count') do
			post submissions_url,
			     params: {
					submission: {
						question_id: @submission.question_id,
						submission_set_id: @submission.submission_set_id
					}
			     },
			     as: :json,
			     headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
			     }
		end
		assert_response 201

		assert_difference('Submission.count') do
			post submissions_url,
			     params: {
					submission: {
						question_id: @submission.question_id,
						submission_set_id: @submission.submission_set_id
					}
			     },
			     as: :json,
			     headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
			     }
		end
		assert_response 201
	end

	# survey_owner und submitter
	test 'should show submission' do
		get submission_url(@submission),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response 403

		get submission_url(@submission),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success

		get submission_url(@submission),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		    }
		assert_response :success
	end

	# submitter
	test 'should update submission' do
		patch submission_url(@submission),
		      params: {
				submission: {
					question_id: @submission.question_id,
					submission_set_id: @submission.submission_set_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		      }
		assert_response 403

		patch submission_url(@submission),
		      params: {
				submission: {
					question_id: @submission.question_id,
					submission_set_id: @submission.submission_set_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		      }
		assert_response 403

		patch submission_url(@submission),
		      params: {
				submission: {
					question_id: @submission.question_id,
					submission_set_id: @submission.submission_set_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		      }
		assert_response 200
	end

	# submitter
	test 'should destroy submission' do
		delete submission_url(@submission),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		       }
		assert_response 403

		delete submission_url(@submission),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		       }
		assert_response 403

		assert_difference('Submission.count', -1) do
			delete submission_url(@submission),
			       as: :json,
			       headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
			       }
		end
		assert_response 204
	end
end
