class Survey < ApplicationRecord
	belongs_to :user
	has_many :questions
	has_many :submission_sets

	# validation
	validates :name, presence: true, uniqueness: true
	validate :datetime_valid_from
	validate :datetime_valid_to

	# eigene Validierungsmethode
	# TODO: fromDate muss vor toDate liegen

end
