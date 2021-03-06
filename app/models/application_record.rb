class ApplicationRecord < ActiveRecord::Base
	self.abstract_class = true

	class_attribute :is_abstract, default: true

	validate :dont_save_abstract
	def dont_save_abstract
		errors.add(:base, 'Cannot save abstract class') if self.is_abstract
	end
end
