require 'test_helper'

class StringQuestionsControllerTest < ActionDispatch::IntegrationTest
	setup { @string_question = string_questions(:one) }

	test 'should get index' do
		get string_questions_url, as: :json
		assert_response :success
	end

	test 'should create string_question' do
		assert_difference('StringQuestion.count') do
			post string_questions_url,
			     params: {
					string_question: {}
			     },
			     as: :json
		end

		assert_response 201
	end

	test 'should show string_question' do
		get string_question_url(@string_question), as: :json
		assert_response :success
	end

	test 'should update string_question' do
		patch string_question_url(@string_question),
		      params: {
				string_question: {}
		      },
		      as: :json
		assert_response 200
	end

	test 'should destroy string_question' do
		assert_difference('StringQuestion.count', -1) do
			delete string_question_url(@string_question), as: :json
		end

		assert_response 204
	end
end
