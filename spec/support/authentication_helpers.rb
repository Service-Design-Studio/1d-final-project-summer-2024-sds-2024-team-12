# spec/support/authentication_helpers.rb
module AuthenticationHelpers
    def sign_up(phone_number:, pin:, pin_confirmation:)
      visit sign_up_path
      fill_in 'Enter your phone number', with: phone_number
      fill_in 'PIN (6 digits)', with: pin
      fill_in 'Confirm your PIN', with: pin_confirmation
      click_button 'Sign Up'
    end
  
    def login(phone_number:, pin:)
      visit sign_in_path
      fill_in 'Enter phone number', with: phone_number
      fill_in ' Enter PIN', with: pin
      click_button 'Sign In'
    end
  end
  
  RSpec.configure do |config|
    config.include AuthenticationHelpers, type: :feature
  end
  
  