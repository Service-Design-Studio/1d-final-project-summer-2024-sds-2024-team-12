require 'rails_helper'

RSpec.feature "search", type: :feature, js: true do
  let(:valid_phone_number) { '1234567890' }
  let(:valid_pin) { '123456' }

  before(:each) do
    #seed contact database
    Contact.create(name: "Nicole", phone_number: "87654321")
    # Ensure user is signed up and logged in before each scenario
    visit sign_in_path
    click_link 'Sign Up'
    sign_up(phone_number: valid_phone_number, pin: valid_pin, pin_confirmation: valid_pin)
    visit sign_in_path
    login(phone_number: valid_phone_number, pin: valid_pin)
  end

  scenario "search limit" do
    visit root_path
    # Click on the search input container to activate the search input
    find('.search-container').click
    
    # Ensure the search input field is present and then fill it in
    expect(page).to have_selector('input#search-input', wait: 10)
    fill_in 'search-input', with: 'How to find limit?'
    # Click the search button to submit the form
    find('button#search-button').click
    expect(page).to have_current_path(new_cardlimit_path, wait: 10)
    expect(page).to have_content('Local Transfer Limit')
  end

  scenario "pay user successfully through searchbar" do
    visit root_path
    # Click on the search input container to activate the search input
    find('.search-container').click
    
    # Ensure the search input field is present and then fill it in
    expect(page).to have_selector('input#search-input', wait: 10)
    fill_in 'search-input', with: 'Pay Nicole 100 dollars'
    # Click the search button to submit the form
    find('button#search-button').click
    expect(page).to have_current_path(/\/transactions\/new\?amount=\d+&name=\d+/, wait: 10)
    #expect(page).to have_content('Local Transfer Limit')
  end
  


end