class CardlimitController < ApplicationController
  CARD_LIMIT = 500

  # GET /transactions or /transactions.json
  def index
    @card_limit = CARD_LIMIT  # Pass the constant to the view
  end

  def paynow
    # Action logic for paynow
  end

end
