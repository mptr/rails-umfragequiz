class NpsQuestion < Question
    has_many :number_submissions, as: :number_question
end
