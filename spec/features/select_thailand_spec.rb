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
    visit overseas_transfer_select_location_path
    click_link 'Thailand'
    expect(page).to have_selector('#promptPayModal', visible: true)
    expect(page).to have_text('You are sending money to Thailand, would you want to use our PromptPay feature to send money to Thailand more conveniently?')
  end

  scenario "User selects United Kingdom and does not see the PromptPay modal" do
    visit overseas_transfer_select_location_path
    click_link 'United Kingdom'
    expect(page).to have_no_css('#promptPayModal', visible: true)
  end

  scenario "User selects PromptPay option after selecting Thailand" do
    visit overseas_transfer_select_location_path
    click_link 'Thailand'
    expect(page).to have_selector('#promptPayModal', visible: true)
    within('#promptPayModal') do
      click_link 'Use PromptPay'
    end
    expect(page).to have_current_path(promptpay_path)
  end

  scenario "User able to use PromptPay successfully" do
    visit promptpay_path
    fill_in 'Recipient Number', with: '123456789'
    fill_in 'sgdAmount', with: '100'
    click_button 'NEXT'
    # Expect the user to be redirected to the transactions page
    expect(page).to have_current_path(transactions_path, wait: 10)
  end

  scenario "User not able to use PromptPay successfully" do
    visit promptpay_path
    fill_in 'Recipient Number', with: '1234567'
    fill_in 'sgdAmount', with: '100'
    click_button 'NEXT'
    # Expect the user to remain on the promptpay_path due to validation error
    expect(page).to have_current_path(promptpay_path)
  end

  scenario "User rejects PromptPay option after selecting Thailand" do
    visit overseas_transfer_select_location_path
    click_link 'Thailand'
    expect(page).to have_selector('#promptPayModal', visible: true)
    within('#promptPayModal') do
      click_link 'Proceed without PromptPay'
    end
    expect(page).to have_current_path(overseas_transfer_new_recipient_path(country: 'Thailand'))
  end
end
