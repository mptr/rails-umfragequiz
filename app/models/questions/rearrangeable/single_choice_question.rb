class SingleChoiceQuestion < MultipleChoiceQuestion
	before_save :default_values
	def default_values
		self.up_to = 1
	end
end
SingleChoiceQuestion.is_abstract = false
