class NumberRangeQuestion < Question
    has_many :number_submissions, as: :number_question

    # validation
    validates :from, :to, :step, presence: true
end
