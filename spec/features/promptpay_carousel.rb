require 'rails_helper'

RSpec.feature "Selecting Thailand", type: :feature, js: true do
  let(:valid_phone_number) { '1234567890' }
  let(:valid_pin) { '123456' }

  before(:each) do
    # Ensure user is signed up and logged in before each scenario
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: valid_phone_number, pin: valid_pin, pin_confirmation: valid_pin)
    
    visit sign_in_path
    login(phone_number: valid_phone_number, pin: valid_pin)
  end

  scenario "User selects Thailand and sees PromptPay modal" do  
    visit transactions_path
    within('.carousel-inner') do
       expect(page).to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
    end
    click_button 'Go Now'

  end

  


end

