require 'test_helper'

class SubmissionSetsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@survey_owner = users(:two)
		@survey = @survey_owner.surveys.sample
		@submission_set =
			@survey.submission_sets.where.not(user_id: @survey_owner.id).sample

		@submitter = @submission_set.user

		@other_user =
			User
				.where.not(id: @survey_owner.id)
				.where.not(id: @submitter.id)
				.sample
	end

	# nur owner
	test 'should get index' do
		get submission_set_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success

		get submission_set_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		    }
		assert_response :success
	end

	test 'should create submission_set' do
		s = Survey.new(from_date: DateTime.now, to_date: DateTime.tomorrow, name: "Test Survey928364")
		s.user = User.first
		q = Question.new(type: "TextQuestion", description: "Test Question01", optional: false)
		s.save
		post submission_sets_url(@survey),
		     params: {
				submission_set: {
					survey_id: s.id,
					user_id: @other_user.id,
				},
		     },
		     as: :json,
		     headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		     }
		assert_response 400 # (because submissions not match)
	end

	# owner und submitter
	test 'should show submission_set' do
		get submission_set_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		    }
		assert_response 403

		get submission_set_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		    }
		assert_response :success

		get submission_set_url(@submission_set),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		    }
		assert_response :success
	end

	test 'submission_set should be immutable (patch)' do
		patch submission_set_url(@submission_set),
		      params: {
				submission_set: {
					survey_id: @submission_set.survey_id,
					user_id: @submission_set.user_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@other_user)
		      }
		assert_response 405

		patch submission_set_url(@submission_set),
		      params: {
				submission_set: {
					survey_id: @submission_set.survey_id,
					user_id: @submission_set.user_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		      }
		assert_response 405

		patch submission_set_url(@submission_set),
		      params: {
				submission_set: {
					survey_id: @submission_set.survey_id,
					user_id: @submission_set.user_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
		      }
		assert_response 405
	end

	test 'should delete submission_set' do
		delete submission_set_url(@submission_set),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@survey_owner)
		       }
		assert_response 403

		assert_difference('SubmissionSet.count', -1) do
			delete submission_set_url(@submission_set),
				as: :json,
				headers: {
					'HTTP_AUTHORIZATION' => generate_token_for(@submitter)
				}
			assert_response :success
			end
	end
end
