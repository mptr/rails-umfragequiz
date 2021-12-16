class RearrangeableQuestion < Question
    has_many :multiple_number_submissions

    attribute :answerOptions, :json_list
end
