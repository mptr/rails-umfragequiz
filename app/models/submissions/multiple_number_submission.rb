class MultipleNumberSubmission < Submission
	#belongs_to :rearrangeable_question

	attribute :answers, :json_list
	alias_attribute :answer, :answers
end
MultipleNumberSubmission.is_abstract = false
