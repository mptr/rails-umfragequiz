class StringQuestion < Question
    has_many :string_submissions, dependent: :destroy
end
