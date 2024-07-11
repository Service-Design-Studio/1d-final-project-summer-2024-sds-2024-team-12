# phone: int
# password_digest: int

# password: int virtual
# password_confirmation: int virtual

class User < ApplicationRecord
    has_many :transactions
    has_many :shortcuts
    has_secure_password

    validates :phone, presence: true, uniqueness: true
    # validates :password, presence: true, length: { minimum: 6 }
    # validates :password_confirmation, presence: true
end
