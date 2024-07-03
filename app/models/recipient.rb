# app/models/recipient.rb
class Recipient < ApplicationRecord
    # Define any validations or associations here
    # this is for recipients in overseas transfer
    def initials
      full_name.split.map(&:first).join.upcase
    end
  end
  