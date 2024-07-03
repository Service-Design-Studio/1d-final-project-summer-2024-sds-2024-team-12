class ScheduledTransactionsController < ApplicationController
  def create
    @scheduled_transaction = ScheduledTransaction.new(scheduled_transaction_params)

    if @scheduled_transaction.save
      # Handle successful save, e.g., redirect to a success page
      redirect_to @scheduled_transaction, notice: 'Scheduled transaction was successfully created.'
    else
      # Handle validation errors or other failure cases
      render :new
    end
  end

  private

  def scheduled_transaction_params
    params.require(:scheduled_transaction).permit(:amount, :name)
  end
end
