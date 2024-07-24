class Suggestion < ApplicationRecord
  belongs_to :user
  validates :suggestion_type, presence: true
  validates :content, presence: true
  validates :link_url, presence: true
end
