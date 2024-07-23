class ApplicationController < ActionController::Base
  before_action :set_current_user

  helper BackButtonHelper

  def set_current_user
    if session[:user_id]
      begin
        Current.user = User.find(session[:user_id])
      rescue ActiveRecord::RecordNotFound
        session[:user_id] = nil
        redirect_to sign_in_path
      end
    end
  end

  def check_if_user
    if not Current.user
      redirect_to sign_in_path
    end
  end
end
