class Transaction < ApplicationRecord
  validates :name, presence: true
  validates :amount, numericality: { greater_than: 0 }
  validate :amount_must_have_two_decimal_places

  private

  def amount_must_have_two_decimal_places
    unless amount.to_s.match?(/\A\d+(\.\d{1,2})?\z/)
      errors.add(:amount, "must have at most two decimal places")
    end
  end

  def self.recurring_transactions(threshold = 3)
    group(:name, :amount)
      .having('COUNT(*) >= ?', threshold)
      .pluck(:name, :amount)
  end
end
