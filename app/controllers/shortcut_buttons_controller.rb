class ShortcutButtonsController < ApplicationController
    def new
      @shortcut_button = ShortcutButton.new
    end
  
    def create
      @shortcut_button = ShortcutButton.new(shortcut_button_params)
      if @shortcut_button.save
        redirect_to root_path, notice: 'Shortcut button was successfully created.'
      else
        render :new
      end
    end

    def destroy
        @shortcut_button = ShortcutButton.find(params[:id])
        @shortcut_button.destroy
        redirect_to root_path, notice: 'Shortcut button was successfully deleted.'
    end
  
    private
  
    def shortcut_button_params
      params.require(:shortcut_button).permit(:name_of_widget)
    end
    
  end