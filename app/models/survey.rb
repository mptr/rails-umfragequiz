class Survey < ApplicationRecord
	belongs_to :user
	has_many :questions
	has_many :submission_sets

	# validation
	validates :name, presence: true, uniqueness: true
	validate :from_date_before_to_date
	def from_date_before_to_date
		if fromDate.present? && toDate.present? && fromDate > toDate
			errors.add(:from_date, "fromDate must be before toDate")
		end
	end
end
