class MainController < ApplicationController
    def index
        if Current.user
            redirect_to transactions_path
        else
            redirect_to sign_in_path
        end

    end

end
