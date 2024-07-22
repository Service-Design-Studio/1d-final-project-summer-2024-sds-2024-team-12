# spec/features/sign_in_spec.rb
require 'rails_helper'

RSpec.feature "User Sign In", type: :feature do
  let(:valid_phone_number) { '1234567890' }
  let(:valid_pin) { '123456' }
  let(:invalid_phone_number) { '123456' }
  let(:invalid_pin) { '654321' }

  before do
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: valid_phone_number, pin: valid_pin, pin_confirmation: valid_pin)
    visit sign_in_path
  end

  scenario "User signs in successfully with valid credentials" do
    login(phone_number: valid_phone_number, pin: valid_pin)
    expect(page).to have_current_path(transactions_path)
  end

  scenario "User enters incorrect phone number" do
    login(phone_number: '0987654321', pin: valid_pin)
    expect(page).to have_current_path(sign_in_path)
  end

  scenario "User enters incorrect PIN" do
    login(phone_number: valid_phone_number, pin: invalid_pin)
    expect(page).to have_current_path(sign_in_path)
  end

  scenario "User logs out successfully" do
    login(phone_number: valid_phone_number, pin: valid_pin)
    expect(page).to have_current_path(transactions_path)

    # Assuming you have a logout link/button with id 'logout'
    find('.logoutContainer .transparent').click
    expect(page).to have_content("Logged out")
    expect(page).to have_current_path(sign_in_path)
  end
end

