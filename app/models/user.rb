# phone: int
# password_digest: int

# password: int virtual
# password_confirmation: int virtual

class User < ApplicationRecord
    has_many :transactions, dependent: :destroy
    has_many :scheduled_transactions
    has_many :shortcuts
    has_many :suggestions
    has_many :user_actions


    has_secure_password

    validates :phone, presence: true, uniqueness: true, length: { in: 7..15 }
    validates :password, presence: true, length: { minimum: 6 }
    # validates :password_confirmation, presence: true

    def most_frequent_actions(limit = 3)
        user_actions.order(count: :desc).limit(limit)
      end
end
