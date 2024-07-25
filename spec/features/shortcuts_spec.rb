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

  shared_examples "transfer scenario" do |option|
    it "completes a transfer and handles the popup with #{option} option" do
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

          # Choose the option based on the provided parameter
          if option == 'schedule'
            find('.scheduleButton').click
            expect(page).to have_current_path(%r{/scheduled_transactions/new}, wait: 10)
            # Checking prefilled fields
            expect(find_field('Recipient').value).to eq('123456')
            amount_field = find('#ScheduledAmount')
            expect(amount_field.value).to eq('100.0')

            # Filling in the start date and frequency
            fill_in 'Start Date', with: '01/08/2024'
            select 'Daily', from: 'Frequency'

            click_button 'SAVE'
            expect(page).to have_text('Scheduled transaction was successfully created.')
            visit scheduled_transactions_path
            expect(page).to have_content('Name: 123456')
            expect(page).to have_content('Amount: SGD 100.00')
            expect(page).to have_content('Start Date: 2024-08-01')
            expect(page).to have_content('Frequency: Daily')

          elsif option == 'shortcut'
            find('.shortcut').click
            expect(page).to have_current_path(%r{/shortcuts/new}, wait: 10)
          end
        end
      end
    end
  end

  describe "Shortcut suggestions appear with Schedule Payment option on the third transfer" do
    it_behaves_like "transfer scenario", 'schedule'
  end

  describe "Shortcut suggestions appear with Make a Quick Shortcut option on the third transfer" do
    it_behaves_like "transfer scenario", 'shortcut'
  end


  scenario "choose shortcuts option" do
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
    
      click_link 'MAKE ANOTHER TRANSFER' if i < 2
      expect(page).to have_current_path(transactions_path) if i < 2
    end

    # Now check for the carousel part
    visit root_path
    within('.carousel-inner') do
      expect(page).to have_text('Based on your frequent transactions, consider scheduling a payment or creating a shortcut for:', wait: 20)
    end

  end





  


end

