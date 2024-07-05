class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
        Current.user = User.find(session[:user_id])
    end
  end

  def check_if_user
    if not Current.user?
      redirect_to sign_in_path
    end
  end


end
