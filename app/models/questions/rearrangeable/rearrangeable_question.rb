class RearrangeableQuestion < Question
	# has_many :multiple_number_submissions, dependent: :destroy, as: :question

	attribute :answer_options, :json_list
end
