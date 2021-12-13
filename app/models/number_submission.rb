class NumberSubmission < Submission
    belongs_to :number_range_question

    alias_attribute :answer, :answer_number

    # TODO: validate answer between "from" and "to" from NumberRangeQuestion
end
