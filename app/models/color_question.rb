class ColorQuestion < Question
    has_many :text_submissions, as: :string_question
end
