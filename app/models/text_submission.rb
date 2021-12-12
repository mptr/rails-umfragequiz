class TextSubmission < Submission
  belongs_to :string_question, polymorphic: true

  alias_attribute :answer, :answer_string

  # validation
  validates :answer, presence: true
end
