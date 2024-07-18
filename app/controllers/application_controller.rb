class ApplicationController < ActionController::Base
  def set_current_user
    if session[:user_id]
      if User.find(session[:user_id])
        Current.user = User.find(session[:user_id])
      else
        Current.user = 1
      end
    end
  end

end
