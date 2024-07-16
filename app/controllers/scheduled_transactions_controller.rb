class ScheduledTransactionsController < ApplicationController
  def new
    @scheduled_transaction = ScheduledTransaction.new
    # @frequent_transaction = OpenStruct.new(name: scheduled_transaction_params[:name], amount: scheduled_transaction_params[:amount])
  end


  def create
    @scheduled_transaction = ScheduledTransaction.new(scheduled_transaction_params)

    if @scheduled_transaction.save
      redirect_to root_path, notice: 'Scheduled transaction was successfully created.'
    else
      render :new
    end
  end

  def index
    @scheduled_transactions = ScheduledTransaction.all
  end

  private

  def scheduled_transaction_params
    params.require(:scheduled_transaction).permit(:amount, :name, :start_date, :frequency)
  end
end
