require 'test_helper'

class NumberSubmissionsControllerTest < ActionDispatch::IntegrationTest
	setup { @number_submission = number_submissions(:one) }

	test 'should get index' do
		get number_submissions_url, as: :json
		assert_response :success
	end

	test 'should create number_submission' do
		assert_difference('NumberSubmission.count') do
			post number_submissions_url,
			     params: {
					number_submission: {}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show number_submission' do
		get number_submission_url(@number_submission), as: :json
		assert_response :success
	end

	test 'should update number_submission' do
		patch number_submission_url(@number_submission),
		      params: {
				number_submission: {}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy number_submission' do
		assert_difference('NumberSubmission.count', -1) do
			delete number_submission_url(@number_submission), as: :json
		end

		assert_response 204
	end
end
