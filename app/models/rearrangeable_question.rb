class RearrangeableQuestion < Question
    has_many :multiple_number_submissions

    def answerOptionList
        @answerOptionList
    end
    def answerOptionList=(l)
        @answerOptionList = l
    end

    after_initialize :from_json
    after_save :from_json
    def from_json
        self.answerOptionList = JSON.parse(self.answerOptions)
    end

    before_save :to_json
    def to_json
        self.answerOptions = self.answerOptionList.to_json
    end
end
