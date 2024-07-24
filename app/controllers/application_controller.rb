class ApplicationController < ActionController::Base
  before_action :set_current_user
  before_action :track_action

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

  private

  def track_action
    return unless Current.user

    controller_name = params[:controller] # e.g., 'transactions'
    action_name = params[:action] # e.g., 'new'
    user_action = Current.user.user_actions.find_or_initialize_by(controller: controller_name, action: action_name)
    user_action.increment(:count)
    user_action.save
  end
end
