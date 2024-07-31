class OverseasController < ApplicationController
    def overseas_transfer
      @recipients = Recipient.all
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
        session[:bank_name] = params[:bank_name]
        session[:account_details] = params[:account_details]
        session[:country] = params[:country]
     
        redirect_to overseas_transfer_confirmation_path
      else
        # Handle errors or validation failures
        render :new_recipient # Render the new recipient form again with errors
      end
    end
  
    def confirmation
      @bank_name = session[:bank_name]
      @account_details = session[:account_details]
      @country = session[:country]
    end
  
    def make_transfer
      @recipient = Recipient.find(params[:recipient_id])  # Fetch recipient
      @transaction = Transaction.new
    end

    def create_transfer
      @transaction = Transaction.new(transaction_params)
      if @transaction.save
        redirect_to success_path, notice: 'Transfer was successfully made.'
      else
        @recipient = Recipient.find(params[:transaction][:recipient_id])
        render :make_transfer, status: :unprocessable_entity
      end
    end
  
    private
  
    def recipient_params
      params.permit(:country, :account_details, :full_name, :registered_address)
    end

    def transaction_params
      params.require(:transaction).permit(:name, :amount)
    end
  end
  