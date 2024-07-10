class ScheduledTransaction< ApplicationRecord
  validates :amount, :name, :start_date, :frequency, presence: true
end
