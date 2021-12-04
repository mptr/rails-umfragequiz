class TextSubmission < Submission
  belongs_to :string_question, polymorphic: true
end
