require 'test_helper'

class NumberQuestionsControllerTest < ActionDispatch::IntegrationTest
	setup { @number_question = number_questions(:one) }

	test 'should get index' do
		get number_questions_url, as: :json
		assert_response :success
	end

	test 'should create number_question' do
		assert_difference('NumberQuestion.count') do
			post number_questions_url,
			     params: {
					number_question: {}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show number_question' do
		get number_question_url(@number_question), as: :json
		assert_response :success
	end

	test 'should update number_question' do
		patch number_question_url(@number_question),
		      params: {
				number_question: {}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy number_question' do
		assert_difference('NumberQuestion.count', -1) do
			delete number_question_url(@number_question), as: :json
		end

		assert_response 204
	end
end
