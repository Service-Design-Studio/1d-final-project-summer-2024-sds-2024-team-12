# class SuggestionsController < ApplicationController
#   before_action :set_current_user
#   before_action :check_if_user
#   before_action :set_suggestion, only: [:show, :edit, :update, :destroy]

#   def index
#     @suggestions = Current.user.suggestions.where(user_dismissed: false).order(created_at: :desc)
#   end

#   def show
#   end

#   def new
#     @suggestion = current_user.suggestions.build
#   end

#   def create
#     @suggestion = current_user.suggestions.build(suggestion_params)
#     if @suggestion.save
#       redirect_to @suggestion, notice: 'Suggestion was successfully created.'
#     else
#       render :new
#     end
#   end

#   def edit
#   end

#   def update
#     if @suggestion.update(suggestion_params)
#       redirect_to @suggestion, notice: 'Suggestion was successfully updated.'
#     else
#       render :edit
#     end
#   end

#   def destroy
#     @suggestion.update(user_dismissed: true)
#     redirect_to suggestions_url, notice: 'Suggestion was successfully dismissed.'
#   end

#   private

#   def set_suggestion
#     @suggestion = current_user.suggestions.find(params[:id])
#   end

#   def suggestion_params
#     params.require(:suggestion).permit(:type, :content, :link_url)
#   end
# end
