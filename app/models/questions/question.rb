class Question < ApplicationRecord
  belongs_to :survey

  # sends className aka type of question as name of object
  ActiveRecord::Base.include_root_in_json = true

  def as_json options={}
    {
      type: type,
      id: id,
      from: from,
      to: to,
      step: step,
      up_to: up_to,
      answer_options: answer_options,
      questions: questions,
      optional: optional,
      description: description,
      survey_id: survey_id,
      created_at: created_at,
      updated_at: updated_at
    }
  end


  # validation
  validates :optional, inclusion: { in: [ true, false ] }
  validates :description, presence: true
end
