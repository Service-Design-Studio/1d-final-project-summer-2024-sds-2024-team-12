class OverseasController < ApplicationController
    def overseas_transfer
    end
  
    def select_location
      @countries = ["Thailand", "United States", "United Kingdom", "Australia", "Canada"]
    end
  
    def new_recipient
      @country = params[:country]
    end
  
    def create_recipient
      # Handle form submission and save recipient details
      recipient = Recipient.new(recipient_params)
      if recipient.save
        redirect_to overseas_transfer_confirmation_path
      else
        render :new_recipient
      end
    end
  
    def confirmation
    end
  
    def make_transfer
    end
  
    private
  
    def recipient_params
      params.require(:account_details, :full_name, :registered_address, :country)
    end
  end
  