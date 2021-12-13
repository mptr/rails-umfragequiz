class RearrangeableQuestion < Question
    has_many :multiple_number_submissions

    # TODO: Arrays in dieser und unterklassen Marshalled
    # speichern, siehe:
    # https://ruby-doc.org/core-2.6.3/Marshal.html
end
