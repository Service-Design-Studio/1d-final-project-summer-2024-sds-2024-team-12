# spec/features/sign_up_spec.rb
require 'rails_helper'


RSpec.feature "User Sign Up", type: :feature do
  let(:valid_phone_number) { '1234567890' }
  let(:valid_pin) { '123456' }
  let(:invalid_phone_number) { '123456' }
  let(:invalid_pin) { '654321' }


  scenario "User signs up with phone number too short" do
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: '123456', pin: '123456', pin_confirmation: '123456')
    expect(page).to have_content("Phone is too short (minimum is 7 characters)")
    expect(page).to have_current_path(sign_up_path)
  end


  scenario "User signs up with PIN not exactly 6 digits" do
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: '1234567890', pin: '12345', pin_confirmation: '12345')
    expect(page).to have_content("Password is too short (minimum is 6 characters)")
    expect(page).to have_current_path(sign_up_path)
  end

  scenario "User signs up successfully with valid phone number and PIN" do
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: '1234567890', pin: '123456', pin_confirmation: '123456')
    expect(page).to have_content("Successfully created account.")  # Adjust to match actual post-sign-up content
    expect(page).to have_current_path(sign_in_path)  # Adjust to actual post-sign-up path
  end
end


