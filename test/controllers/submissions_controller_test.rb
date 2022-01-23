require 'test_helper'

class SubmissionsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@survey_owner = users(:one)
		@submission_set =
			@survey_owner
				.surveys
				.sample
				.submission_sets
				# .where.not(user_id: @survey_owner.id)
				.sample
		@submission = @submission_set.submissions.sample

		@submitter = @submission_set.user

		@other_user =
			User
				.where.not(id: @survey_owner.id)
				.where.not(id: @submitter.id)
				.sample
	end

	# survey_owner und submitter
	test 'should get index' do
		get submissions_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		    }
		assert_response 403

		get submissions_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success

		get submissions_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		    }
		assert_response :success
	end

	# alle
	test 'should create submission' do
		post submissions_url(@submission_set),
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
		assert_response 405 # submissions inserted via submission set

		post submissions_url(@submission_set),
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
		assert_response 405 # submissions inserted via submission set

		post submissions_url(@submission_set),
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
		assert_response 405 # submissions inserted via submission set
	end

	# survey_owner und submitter
	test 'should show submission' do
		get submission_url(@submission),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
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
	test 'submission should be immutable (update)' do
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
		assert_response 405

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
		assert_response 405

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
		assert_response 405
	end

	# submitter
	test 'submission should be immutable (delete)' do
		delete submission_url(@submission),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		       }
		assert_response 405

		delete submission_url(@submission),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		       }
		assert_response 405

		delete submission_url(@submission),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		       }
		assert_response 405
	end

	test 'submission should have type' do
		get submission_url(@submission),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success
		assert JSON.parse(response.body)['type']
	end
end
