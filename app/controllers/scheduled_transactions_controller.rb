class ScheduledTransactionsController < ApplicationController
  before_action :set_current_user
  before_action :check_if_user
  before_action :set_scheduled_transaction, only: [:destroy]

  def new
    @scheduled_transaction = Current.user.scheduled_transactions.new
    @frequent_transaction = OpenStruct.new(name: params[:name], amount: params[:amount]) # Autofill based on params, adjust as needed
  end

  def create
    @scheduled_transaction = Current.user.scheduled_transactions.new(scheduled_transaction_params)

    if @scheduled_transaction.save
      redirect_to root_path, notice: 'Scheduled transaction was successfully created.'
    else
      render :new
    end
  end

  def index
    @scheduled_transactions = Current.user.scheduled_transactions
  end

  def destroy
    @scheduled_transaction.destroy
    respond_to do |format|
      format.html { redirect_to scheduled_transactions_url, notice: "Scheduled transaction was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private

  def set_scheduled_transaction
    @scheduled_transaction = Current.user.scheduled_transactions.find(params[:id])
  end

  def scheduled_transaction_params
    params.require(:scheduled_transaction).permit(:amount, :name, :start_date, :frequency)
  end
end
