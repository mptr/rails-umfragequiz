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

    # validation all questions answered

    # before_validation :all_questions_answered
    # before_destroy :all_questions_answered

	def all_questions_answered
		if question.survey.questions.length == submission_set.submissions.length
            raise "not all questions are answered"
		end
	end
end
