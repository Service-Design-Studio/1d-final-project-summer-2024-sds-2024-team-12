# app/controllers/pay_and_transfer_page_controller.rb
class PayAndTransferPageController < ApplicationController
  before_action :set_current_user
  before_action :check_if_user

  def index
    @shortcut = Current.user.shortcuts
  end
end
