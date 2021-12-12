class Submission < ApplicationRecord
  self.abstract_class = true
  
  belongs_to :submission_set
  belongs_to :question
end
