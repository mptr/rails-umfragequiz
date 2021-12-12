class User < ApplicationRecord
    has_many :surveys
    has_many :submission_sets

    # validation
    validates :username, presence: true, uniqueness: true, format: { with: /^\w{3,}$/, message: ' - mindestens 3 nicht-leere Zeichen!' }
    validates :email, presence: true, uniqueness: true, format: { with: /^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$/, message: ' - gültige E-Mail-Adresse verwenden!' }
end
