class SingleChoiceQuestion < MultipleChoiceQuestion
    before_save :default_values
    def default_values
        self.upTo = 1
    end
end
