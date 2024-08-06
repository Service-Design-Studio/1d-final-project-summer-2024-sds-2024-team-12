class ShortcutsController < ApplicationController
  before_action :set_current_user
  before_action :check_if_user
  def new
    @shortcut = Current.user.shortcuts.new
  end

  def create
    @shortcut = Current.user.shortcuts.new(shortcut_params)

    if @shortcut.save
      redirect_to pay_and_transfer_page_index_path, notice: 'Shortcut button was successfully created.'
    # else
    #   render :new
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
