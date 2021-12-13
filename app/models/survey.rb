class Survey < ApplicationRecord
	belongs_to :user
	has_many :questions
	has_many :submission_sets

	# validation
	validates :name, presence: true, uniqueness: true
	validate :datetime_valid_from
	validate :datetime_valid_to

	# eigene Validierungsmethode
	# TODO: How to refactor?
	def datetime_valid_from
		if ((DateTime.parse(fromDate) rescue ArgumentError) == ArgumentError)
			errors.add(:fromDate, "Startdatum ungültig")
		end
	end
	def datetime_valid_to
		if ((DateTime.parse(toDate) rescue ArgumentError) == ArgumentError)
			errors.add(:toDate, "Enddatum ungültig")
		end
	end

end
