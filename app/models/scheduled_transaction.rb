class ScheduledTransaction< ApplicationRecord
  belongs_to :user

  validates :amount, :name, :start_date, :frequency, presence: true
end
