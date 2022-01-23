class Submission < ApplicationRecord
    belongs_to :submission_set
    belongs_to :question

    def as_json options={}
        options[:methods] ||= []
        options[:methods] += [:type, :answer]
        super.as_json(options)
    end
    
    attribute :type
    
    # validation
    validates :answer, presence: true
end
