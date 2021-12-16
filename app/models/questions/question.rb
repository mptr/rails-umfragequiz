class Question < ApplicationRecord
  belongs_to :survey

  # validation
  validates :optional, inclusion: { in: [ true, false ] }
  validates :description, presence: true
end
