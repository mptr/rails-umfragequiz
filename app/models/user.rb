class User < ApplicationRecord
    has_many :surveys
    has_many :submission_sets

    # validation
    validates :username, presence: true, uniqueness: true, format: { with: /\A\w{3,}\z/, message: ' - mindestens 3 nicht-leere Zeichen!' }
    validates :email, presence: true, uniqueness: true, format: {
        with: /\A(|(([A-Za-z0-9]+_+)|([A-Za-z0-9]+\-+)|([A-Za-z0-9]+\.+)|([A-Za-z0-9]+\++))*[A-Za-z0-9]+@((\w+\-+)|(\w+\.))*\w{1,63}\.[a-zA-Z]{2,6})\z/i,
        message: ' - gültige E-Mail-Adresse verwenden!'
    }
end
User.is_abstract = false
