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

  scenario "user makes paynow payment unsuccessfully" do
    visit root_path
    find('button#paynowbutton').click
    expect(page).to have_current_path(enter_transaction_path)
    
    fill_in "Recipient's Mobile No.", with: ''
    click_button 'NEXT'
    expect(page).to have_current_path(/transactions\/new/, wait: 10)
    
    fill_in 'PayNowAmount', with: ''
    click_button 'NEXT'
    #will still be on the same page
    expect(page).to have_current_path(/transactions\/new/, wait: 10)
    expect(page).to have_text("Name can't be blank")
    expect(page).to have_text("Amount is not a number")
    expect(page).to have_text("Amount must have at most two decimal places")
  end

  scenario "user makes paynow payment successfully and goes to transaction history page" do
    visit root_path
    find('button#paynowbutton').click
    expect(page).to have_current_path(enter_transaction_path)
    
    fill_in "Recipient's Mobile No.", with: '123456'
    click_button 'NEXT'
    expect(page).to have_current_path(/transactions\/new/, wait: 10)
    
    fill_in 'PayNowAmount', with: '123'
    click_button 'NEXT'
    #will still be on the same page
    expect(page).to have_current_path(/transactions\/\d+/, wait: 10)
    visit transaction_history_path
    expect(page).to have_text(/PAYNOW TO 123456/)
    expect(page).to have_text(/-123.00/)
    # Click the back button using data-testid
    # find('[data-testid="back-button"]').click
    # expect(page).to have_current_path(transactions_path, wait: 10)

  end



  scenario "Perform transaction three times with amount near 500, suggestion show on carousel" do
    3.times do
      visit root_path
      find('button#paynowbutton').click
      expect(page).to have_current_path(enter_transaction_path)
      
      fill_in "Recipient's Mobile No.", with: '123456'
      click_button 'NEXT'
      expect(page).to have_current_path(/transactions\/new/, wait: 10)
      
      fill_in 'PayNowAmount', with: '499'
      click_button 'NEXT'
      
      expect(page).to have_current_path(/transactions\/\d+/, wait: 10)
    end
    visit transactions_path
    within('.carousel-inner') do
        expect(page).to have_text('Your card usage is nearing $500. Consider setting up a card limit to manage your spending:', wait: 20)
    end
    click_button 'Set up Limit'
    expect(page).to have_current_path(new_cardlimit_path)    
    all('.next-button')[1].click  # Clicks the second '>' button
    expect(page).to have_current_path(cardlimit_paynow_path)

    # Click the only '>' button on the next page
    find('.next-button').click
    expect(page).to have_current_path(cardlimit_adjusting_path)
    click_link 'Back to Home'
    expect(page).to have_current_path(transactions_path)

  end







  


end

