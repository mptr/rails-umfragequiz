class SubmissionSet < ApplicationRecord
  belongs_to :user
  belongs_to :survey

  # validation
  # TODO: 
  # - validate Timestamp
  # - lieber Timestamp aus created_at beziehen?
  # - rails guide caching
  # - transaction
end
