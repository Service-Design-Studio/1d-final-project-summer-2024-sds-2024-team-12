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
      @recipient = Recipient.new(recipient_params)
      if @recipient.save
        redirect_to overseas_transfer_confirmation_path
      else
        # Handle errors or validation failures
        render :new_recipient # Render the new recipient form again with errors
      end
    end
  
    def confirmation
    end
  
    def make_transfer
    end
  
    private
  
    def recipient_params
      params.permit(:country, :account_details, :full_name, :registered_address)
    end
  end
  