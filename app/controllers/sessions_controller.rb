class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(phone: params[:phone])
    if user.present?
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to root_path
      end
    else
      flash[:alert] = "Invalid Phone Number or Password"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Logged out"
  end
end
