class Submission < ApplicationRecord
    belongs_to :submission_set
    belongs_to :question

    def as_json options={}
        super.as_json(options).merge({type:type})
    end

    attribute :type

    # validation
    validates :answer, presence: true
end
