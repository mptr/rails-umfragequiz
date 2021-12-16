class RearrangeableQuestion < Question
    has_many :multiple_number_submissions

    attribute :answer_options, :json_list
end
