class SubmissionSet < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  # validation
  # TODO: validate Timestamp
end
