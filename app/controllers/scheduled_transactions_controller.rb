class ScheduledTransactionsController < ApplicationController
  def new
    @frequent_transaction = Transaction.group(:name, :amount).having('COUNT(*) >= ?', 3).first
  end

  def create
    @scheduled_transaction = ScheduledTransaction.new

    if @scheduled_transaction.save
      # Handle successful save, e.g., redirect to a success page
      redirect_to root_path, notice: 'Scheduled transaction was successfully created.'
      # redirect_to @scheduled_transaction, notice: 'Scheduled transaction was successfully created.'
    else
      # Handle validation errors or other failure cases
      # render :new
      redirect_to root_path
    end
  end

  private

  def scheduled_transaction_params
    params.require(:scheduled_transaction).permit(:amount, :name)
  end
end
