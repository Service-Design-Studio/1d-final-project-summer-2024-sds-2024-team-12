class ScheduledTransactionsController < ApplicationController
  def new
    @transaction = Transaction.new(name: params[:name], amount: params[:amount])
  end

  def create
    @transaction = Transaction.new(transaction_params)

    if @transaction.save
      redirect_to scheduled_transactions_path, notice: "Scheduled transaction was successfully created."
    else
      render :new
    end
  end

  private

  def transaction_params
    params.require(:transaction).permit(:name, :amount)
  end
end
