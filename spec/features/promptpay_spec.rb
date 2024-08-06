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
    expect(page).to have_text("Would you like to use our PromptPay feature to send money to the recipient’s phone number directly ?")
  end

  # scenario "User selects United Kingdom and does not see the PromptPay modal" do
  #   visit overseas_transfer_select_location_path
  #   click_link 'United Kingdom'
  #   expect(page).to have_no_css('#promptPayModal', visible: true)
  # end


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
      click_link 'Proceed with DBS Remit instead'
    end
    expect(page).to have_current_path(overseas_transfer_new_recipient_path(country: 'Thailand'))
  end

  scenario "User creates recipient and uses overseas transfer" do
    visit overseas_transfer_select_location_path
    click_link 'Australia'
    expect(page).to have_current_path(overseas_transfer_new_recipient_path(country: 'Australia'))

    # Use precise CSS selectors to find the input fields
    find('input.newrep2[placeholder="Select recipient\'s bank"]').set('Greenview bank')
    find('input.newrep2[placeholder="Enter account no."]').set('1234567')
    find('input.newrep2[placeholder="Full Name"]').set('Mary')
    find('input.newrep2[placeholder="Full Address"]').set('Hillview')
    find('input.newrep2[placeholder="In The City Of"]').set('Sydney')

    click_button 'NEXT'
    expect(page).to have_current_path(overseas_transfer_confirmation_path)
    click_link 'BACK'
    expect(page).to have_current_path(overseas_transfer_path)
    click_link 'Mary'
    fill_in 'sgdAmount', with: '100'
    click_button 'NEXT'
    expect(page).to have_text("Successful")
    click_link 'MAKE ANOTHER TRANSFER'
    expect(page).to have_current_path(transactions_path, wait:10)
  end

  scenario "User sees promptpay suggestion in carousel" do  
    visit transactions_path

    # Click the lightbulb button to show the suggestions
    find('.fab-container .fab').click

    # Click the second suggestion tab
    within('.suggestion-tabs') do
        all('.suggestion-tablinks')[0].click
    end

    # Wait for the suggestion2 content to be visible
    expect(page).to have_css('#suggestion2', visible: true, wait: 20)

    within('#suggestion2') do
        expect(page).to have_text('for mobile payments to Thai numbers today:', wait: 20)
    end
    click_link 'Proceed to Promptpay'
    expect(page).to have_current_path(promptpay_path)


  end


end
