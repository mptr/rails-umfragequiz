class NumberRangeQuestion < Question
    has_many :number_submissions, dependent: :destroy

    before_validation :default_values
    def default_values
        self.step ||= 1
    end

    # validation
    validates :from, :to, :step, presence: true
end
