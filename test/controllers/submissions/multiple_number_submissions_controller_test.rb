require 'test_helper'

class MultipleNumberSubmissionsControllerTest < ActionDispatch::IntegrationTest
	setup { @multiple_number_submission = multiple_number_submissions(:one) }

	test 'should get index' do
		get multiple_number_submissions_url, as: :json
		assert_response :success
	end

	test 'should create multiple_number_submission' do
		assert_difference('MultipleNumberSubmission.count') do
			post multiple_number_submissions_url,
			     params: {
					multiple_number_submission: {
						rearrangeable_question_id:
							@multiple_number_submission
								.rearrangeable_question_id
					}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show multiple_number_submission' do
		get multiple_number_submission_url(@multiple_number_submission),
		    as: :json
		assert_response :success
	end

	test 'should update multiple_number_submission' do
		patch multiple_number_submission_url(@multiple_number_submission),
		      params: {
				multiple_number_submission: {
					rearrangeable_question_id:
						@multiple_number_submission.rearrangeable_question_id
				}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy multiple_number_submission' do
		assert_difference('MultipleNumberSubmission.count', -1) do
			delete multiple_number_submission_url(@multiple_number_submission),
			       as: :json
		end

		assert_response 204
	end
end
