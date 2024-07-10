class ShortcutButton < ApplicationRecord
  belongs_to :user  # associating shortcuts with users

  validates :nickname, presence: true
  validates :recipient_name, presence: true
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :widget_type, inclusion: { in: ['initials', 'nickname', 'full'] }
end
