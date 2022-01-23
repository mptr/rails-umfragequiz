require 'test_helper'

class QuestionsControllerTest < ActionDispatch::IntegrationTest
	setup do
		@question = questions(:TextQuestion1)
		@some_user = users(:one)
	end

	# Fragen unterschiedlicher Surveys dürfen nicht gleich sein
	test 'should not get all questions' do
		s1 = surveys(:one)
		s2 = surveys(:two)

		get survey_url(s1) + '/questions',
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		    }
		r1 = response.body
		get survey_url(s2) + '/questions',
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		    }
		r2 = response.body

		assert_not_equal r1, r2
	end

	test 'should show question' do
		get question_url(@question),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		    }
		assert_response :success
	end

	test 'question should be immutable (patch)' do
		patch question_url(@question),
		      params: {
				question: {
					description: @question.description,
					optional: @question.optional,
					survey_id: @question.survey_id
				}
		      },
		      as: :json,
		      headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		      }
		assert_response 405
	end

	test 'question should be immutable (delete)' do
		delete question_url(@question),
		       as: :json,
		       headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		       }
		assert_response 405
	end

	test "question should have type" do
		get question_url(@question),
		    as: :json,
		    headers: {
				'HTTP_AUTHORIZATION' => generate_token_for(@some_user)
		    }
		assert JSON.parse(response.body)['type']
	end
end
