class RearrangeableQuestion < Question
	# has_many :multiple_number_submissions, dependent: :destroy, as: :question

	attribute :answer_options, :json_list

	# validation
	validates :answer_options, presence: true

	validate :no_empty_answer_option
	def no_empty_answer_option
		answer_options.each{|answer|
			if answer == '' then
				errors.add(:answer_options, "Contains empty answer option")
			end
		}
	end
end
