class MultipleChoiceQuestion < RearrangeableQuestion
	validates :up_to, numericality: { greater_than: 0}, allow_nil: true
end
MultipleChoiceQuestion.is_abstract = false
