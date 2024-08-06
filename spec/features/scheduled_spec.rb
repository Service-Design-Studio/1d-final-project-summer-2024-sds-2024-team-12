require 'rails_helper'

RSpec.feature "Shortcuts", type: :feature, js: true do
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

  scenario "three transactions got pop up show, then choose schedule payment option in fast actions button" do 
    3.times do |i|
      visit root_path
      find('button#paynowbutton').click
      expect(page).to have_current_path(enter_transaction_path)
      
      fill_in "Recipient's Mobile No.", with: '123456'
      click_button 'NEXT'
      expect(page).to have_current_path(/transactions\/new/, wait: 10)
      
      fill_in 'PayNowAmount', with: '100'
      click_button 'NEXT'
      
      expect(page).to have_current_path(/transactions\/\d+/, wait: 10)

      if i < 2
        click_link 'MAKE ANOTHER TRANSFER'
        expect(page).to have_current_path(transactions_path)
      else
        # Expect the popup to appear on the third transfer
        expect(page).to have_selector('.popupshow', wait: 10)
        expect(page).to have_text('Suggestion:')
        expect(page).to have_text('We noticed you paid')
      end
    end
    visit transactions_path
    # Click the lightbulb button to show the suggestions
    find('.fab-container .fab').click

    # Wait for the suggestion2 content to be visible
    expect(page).to have_css('#suggestion1', visible: true, wait: 20)

    within('#suggestion1') do
        expect(page).to have_text('You might be interested in:', wait: 20)
    end 
    click_link "Schedule Payment" 
    expect(page).to have_current_path(%r{/scheduled_transactions/new}, wait: 10)
    # Checking prefilled fields
    expect(find_field('Recipient').value).to eq('123456')
    amount_field = find('#ScheduledAmount')
    expect(amount_field.value).to eq('100.0')

    # Filling in the start date and frequency
    fill_in 'Start Date', with: '01/08/2024'
    select 'Daily', from: 'Frequency'

    click_button 'SAVE'
    expect(page).to have_text('Ensure that you have sufficient funds in your bank account before the scheduled start date!', wait: 10)
    click_button 'YES'
    visit scheduled_transactions_path
    expect(page).to have_text('Name: 123456', wait: 20)
    expect(page).to have_text('Amount: SGD 100.00')
    expect(page).to have_text('Start Date: 2024-08-01')
    expect(page).to have_text('Frequency: Daily')

end

  scenario "Make scheduled payment directly and delete" do
    visit scheduled_transactions_path
    click_link 'Add a Scheduled Payment'
    fill_in 'Recipient', with: '123456'
    fill_in 'ScheduledAmount', with: '100.0'
    # Filling in the start date and frequency
    fill_in 'Start Date', with: '01/08/2024'
    select 'Daily', from: 'Frequency'

    click_button 'SAVE'
    expect(page).to have_text('Ensure that you have sufficient funds in your bank account before the scheduled start date!', wait: 10)
    click_button 'YES'
    visit scheduled_transactions_path
    expect(page).to have_text('Name: 123456', wait: 20)
    expect(page).to have_text('Amount: SGD 100.00')
    expect(page).to have_text('Start Date: 2024-08-01')
    expect(page).to have_text('Frequency: Daily')

    click_button 'Delete Scheduled Payment'
    expect(page).to_not have_content('Name: 123456', wait:10)
    expect(page).to_not have_content('Amount: SGD 100.00')
    expect(page).to_not have_content('Start Date: 2024-08-01')
    expect(page).to_not have_content('Frequency: Daily')



  end





  


end

