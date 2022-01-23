class LikertQuestion < RearrangeableQuestion
	attribute :questions, :json_list

	validates :questions, presence: true
	validate :no_empty_question_option
	def no_empty_question_option
		questions.each{|elm|
			if elm == '' then
				errors.add(:questions, "Contains empty question")
			end
		}
	end
end
LikertQuestion.is_abstract = false
