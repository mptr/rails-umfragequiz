class NumberSubmission < Submission
    belongs_to :number_question, polymorphic: true

    alias_attribute :answer, :answer_number

    # validation
    validates :answer, presence: true
    # TODO: validate answer between "from" and "to" from NumberRangeQuestion
end
