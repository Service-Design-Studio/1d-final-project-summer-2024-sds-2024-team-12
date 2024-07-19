class Promptpay < ApplicationRecord
    validates :phone_number, presence: true, format: { with: /\A\d{9}\z/, message: "must be exactly 9 digits" }
    validates :amount, numericality: { greater_than: 0 }
  end
  