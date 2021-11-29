class Submission < ApplicationRecord
  belongs_to :submission_set
  belongs_to :question
end
