class ShortcutsController < ApplicationController
  def new
    @shortcut = Shortcut.new
  end

  def create
    @shortcut = Shortcut.new(shortcut_params)
    @shortcut.user = Current.user  # If you're using user authentication
    # @transaction = Current.user.transactions.new(transaction_params)

    if @shortcut.save
      redirect_to pay_and_transfer_page_index_path, notice: 'Shortcut button was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @shortcut = Shortcut.find(params[:id])
    @shortcut.destroy
    redirect_to pay_and_transfer_page_index_path, notice: 'Shortcut was successfully deleted.'
end

  private

  def shortcut_params
    params.require(:shortcut).permit(:nickname, :recipient_name, :amount)
  end
end
