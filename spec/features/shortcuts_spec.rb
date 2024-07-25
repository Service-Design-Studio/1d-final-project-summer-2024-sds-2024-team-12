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

  scenario "Shortcut and scehdule payment suggestions appear with popup on the third transfer" do
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
  end




  


end

