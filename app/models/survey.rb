class Survey < ApplicationRecord
	belongs_to :user
	has_many :questions, -> { order(position: :asc) }, dependent: :destroy
	has_many :submission_sets, dependent: :destroy

	# validation
	validates :name, presence: true, uniqueness: true
	validate :from_date_before_to_date
	def from_date_before_to_date
		if from_date.present? && to_date.present? && from_date > to_date
			errors.add(:from_date, 'from_date must be before to_date')
		end
	end
end
Survey.is_abstract = false
