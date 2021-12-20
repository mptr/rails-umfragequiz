class Question < ApplicationRecord
  belongs_to :survey
  attribute :type
  
  # validation
  validates :optional, inclusion: { in: [ true, false ] }
  validates :description, presence: true
end
