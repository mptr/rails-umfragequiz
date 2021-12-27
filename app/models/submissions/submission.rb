class Submission < ApplicationRecord
    belongs_to :submission_set

    # validation
    validates :answer, presence: true
end
