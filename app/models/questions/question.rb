class Question < ApplicationRecord
  belongs_to :survey

  # sends className aka type of question as name of object
  # ActiveRecord::Base.include_root_in_json = true

  def as_json options={}
    super.as_json(options).merge({type:type})
  end

  # validation
  validates :optional, inclusion: { in: [ true, false ] }
  validates :description, presence: true
end
