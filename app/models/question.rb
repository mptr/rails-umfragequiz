class Question < ApplicationRecord
  belongs_to :survey

  # validation
  # validates :optional, presence: true
  validates :description, presence: true
end
