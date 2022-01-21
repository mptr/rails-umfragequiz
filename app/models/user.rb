class User < ApplicationRecord
    has_many :surveys
    has_many :submission_sets

    # validation
    validates :username, presence: true, uniqueness: true # format validation missing because
    validates :email,    presence: true, uniqueness: true # username and email are already validated through token
end
User.is_abstract = false
