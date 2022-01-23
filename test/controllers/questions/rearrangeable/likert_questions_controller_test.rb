require 'test_helper'

class LikertQuestionsControllerTest < ActionDispatch::IntegrationTest
	setup { @likert_question = likert_questions(:one) }

	test 'should get index' do
		get likert_questions_url, as: :json
		assert_response :success
	end

	test 'should create likert_question' do
		assert_difference('LikertQuestion.count') do
			post likert_questions_url,
			     params: {
					likert_question: {}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show likert_question' do
		get likert_question_url(@likert_question), as: :json
		assert_response :success
	end

	test 'should update likert_question' do
		patch likert_question_url(@likert_question),
		      params: {
				likert_question: {}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy likert_question' do
		assert_difference('LikertQuestion.count', -1) do
			delete likert_question_url(@likert_question), as: :json
		end

		assert_response 204
	end
end
