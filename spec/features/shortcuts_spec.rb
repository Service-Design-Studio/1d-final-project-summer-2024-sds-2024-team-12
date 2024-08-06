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

  scenario "three transactions got pop up show, then choose shortcut option" do 
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
      click_link "Make a Quick Shortcut" 
      expect(page).to have_current_path(%r{/shortcuts/new}, wait: 10)
      page.evaluate_script('window.location.reload()') # Refresh the page
      expect(find_field('shortcut_recipient').value).to eq('123456')
      amount_field = find('#ShortcutAmount')
      expect(amount_field.value).to eq('100.0')
      fill_in 'Shortcut Name', with: 'Amy'
      click_button 'Create Quick Shortcut'
      expect(page).to have_current_path(pay_and_transfer_page_index_path, wait: 10)

  end

  scenario "Make shortcut directly and delete" do
    visit pay_and_transfer_page_index_path
    #css style for adding shortcut link
    find('button.add-recipient').click
    expect(page).to have_current_path(%r{/shortcuts/new}, wait: 10)
    page.evaluate_script('window.location.reload()') # Refresh the page
    fill_in 'shortcut_recipient', with: '123456'
    fill_in 'ShortcutAmount', with: '100.0'
    fill_in 'Shortcut Name', with: 'Amy'
    click_button 'Create Quick Shortcut'
    expect(page).to have_current_path(pay_and_transfer_page_index_path, wait: 10)
    expect(page).to have_text('Amy', wait: 20)
    click_button 'Delete', match: :first
    # Verify that the shortcut has been deleted
    expect(page).to_not have_text('Amy', wait: 20)
  end




end