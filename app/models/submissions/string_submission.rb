class StringSubmission < Submission
    # belongs_to :string_question

    alias_attribute :answer, :answer_string
end
StringSubmission.is_abstract = false
