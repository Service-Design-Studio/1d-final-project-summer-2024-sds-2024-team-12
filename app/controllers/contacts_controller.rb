class ContactsController < ApplicationController
    def check
      contact = Contact.find_by(name: params[:name])
      render json: { exists: contact.present? }
    end
  end
  