class NpsQuestion < Question
    before_save :default_values
    def default_values
        self.from = 1
        self.to = 10
        self.step = 1
    end
end
NpsQuestion.is_abstract = false
