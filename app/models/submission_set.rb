class SubmissionSet < ApplicationRecord
	belongs_to :user
	belongs_to :survey
	has_many :submissions, dependent: :destroy
end
SubmissionSet.is_abstract = false
