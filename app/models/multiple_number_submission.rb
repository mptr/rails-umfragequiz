class MultipleNumberSubmission < Submission
    belongs_to :rearrangeable_question

    attribute :answers, :json_list
end
