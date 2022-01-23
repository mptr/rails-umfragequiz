require 'test_helper'

class SubmissionSetTest < ActiveSupport::TestCase
	test 'should have associations' do
		sset = SubmissionSet.new(survey: Survey.first, user: User.first)

		sset.survey = nil
		assert_not sset.save, 'Saved submission set without survey'
		sset.survey = Survey.first

		sset.user = nil
		assert_not sset.save, 'Saved submission set without user'
		sset.user = User.first

		assert sset.save, 'Failed to save submission set'
	end

	test 'should answer all non optional questions' do
		sset = SubmissionSet.first

		# get a non optional question
		q = sset.survey.questions.where(optional: false).first

		# get the submission for that question
		s = sset.submissions.where(question: q).first

		# delete this submission
		s.delete

		# save the submission set
		assert sset.save,
		       'Failed to save submission set with missing submission to optional question'
	end

	test 'should have submissions acessible through question.submissions' do
		sset = SubmissionSet.first
		%w[TextQuestion NumberQuestion SingleChoiceQuestion].each do |qtype|
			# get a question of each type
			question = sset.survey.questions.where(type: qtype).first

			# get the submissions for that question from sset
			submissionsA = sset.submissions.where(question: question)

			# get the submissions for that question from question still matching the current sset
			submissionsB = question.submissions.where(submission_set: sset)

			# compare their length
			assert_equal submissionsA.count,
			             submissionsB.count,
			             'Submissions from question dont match submissions from submisson set'
		end
	end
end
