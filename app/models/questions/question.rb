class Question < ApplicationRecord
	belongs_to :survey
	has_many :submissions, dependent: :destroy
	acts_as_list scope: :survey

	# sends className aka type of question as name of object
	# ActiveRecord::Base.include_root_in_json = true

	def as_json(options = {})
		options[:methods] ||= []
		options[:methods] += [:type]
		super.as_json(options)
	end

	attribute :type

	# validation
	validates :optional, inclusion: { in: [true, false] }
	validates :description, presence: true
end
