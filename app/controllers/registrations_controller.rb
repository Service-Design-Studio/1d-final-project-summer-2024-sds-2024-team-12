class RegistrationsController < ApplicationController
#   before_action :configure_sign_up_params, only: [:create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to sign_in_path, notice: "Successfully created account."
    else
      flash.now[:alert] = "Failed to create account. Please check the errors below."
      render :new
    end
  end

  private

#   def configure_sign_up_params
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:phone, :password, :password_confirmation])
#   end

  def user_params
    params.require(:user).permit(:phone, :password, :password_confirmation)
  end
end
