class NumberSubmission < Submission
    belongs_to :number_range_question

    alias_attribute :answer, :answer_number

    validate :answer_in_range
    
    def answer_in_range
        if(!(
            answer.between?(number_range_question.from, number_range_question.to  ) ||
            answer.between?(number_range_question.to,   number_range_question.from)
        ))
            errors.add(:answer, "must be between #{number_range_question.from} and #{number_range_question.to}")
        end
    end
end
NumberSubmission.is_abstract = false
