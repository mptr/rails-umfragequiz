require 'test_helper'

class SingleChoiceQuestionsControllerTest < ActionDispatch::IntegrationTest
	setup { @single_choice_question = single_choice_questions(:one) }

	test 'should get index' do
		get single_choice_questions_url, as: :json
		assert_response :success
	end

	test 'should create single_choice_question' do
		assert_difference('SingleChoiceQuestion.count') do
			post single_choice_questions_url,
			     params: {
					single_choice_question: {}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show single_choice_question' do
		get single_choice_question_url(@single_choice_question), as: :json
		assert_response :success
	end

	test 'should update single_choice_question' do
		patch single_choice_question_url(@single_choice_question),
		      params: {
				single_choice_question: {}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy single_choice_question' do
		assert_difference('SingleChoiceQuestion.count', -1) do
			delete single_choice_question_url(@single_choice_question),
			       as: :json
		end

		assert_response 204
	end
end
