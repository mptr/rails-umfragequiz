class RearrangeableQuestion < Question
    has_many :multiple_number_submissions, dependent: :destroy

    attribute :answer_options, :json_list
end
