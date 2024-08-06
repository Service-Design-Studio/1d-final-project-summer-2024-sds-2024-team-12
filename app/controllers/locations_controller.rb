# # app/controllers/locations_controller.rb
# class LocationsController < ApplicationController
#     skip_before_action :verify_authenticity_token, only: [:set_country, :remove_country] # Only if necessary
  
#     def set_country
#       if params[:country].present?
#         session[:country] = params[:country]
#         render json: { success: true }
#       else
#         render json: { success: false, message: "Missing country parameter" }, status: :unprocessable_entity
#       end
#     end
  
#     def remove_country
#         session.delete(:country)
#         render json: { success: true }
#       rescue => e
#         render json: { success: false, error: e.message }, status: :internal_server_error
#     end
#   end
  
  