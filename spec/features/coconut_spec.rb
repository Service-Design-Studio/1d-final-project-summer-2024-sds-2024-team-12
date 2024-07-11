require 'rails_helper'

RSpec.describe "Interaction with the coconut button", type: :feature, js: true do
  before do
    visit transactions_path # Adjust to your actual path
  end

  scenario "updates the carousel to show Thailand-specific content when the coconut button is clicked" do
    # Click the button to set the session
    find("#thailandButton").click

    # Reload the page to ensure the session is set and the carousel is updated
    visit current_path

    # Verify that the Thailand-specific slide is now part of the carousel's inner content
    within('.carousel-inner') do
      expect(page).to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
    end
  end

  scenario "user can click on 'Go Now' button in the Thailand-specific slide" do
    # Click the button to set the session
    find("#thailandButton").click

    # Reload the page to ensure the session is set and the carousel is updated
    visit current_path

    # Verify that the Thailand-specific slide is now part of the carousel's inner content
    within('.carousel-inner') do
      expect(page).to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
      
      # Click the "Go Now" button
      find('a', text: 'Go Now').click
    end

    # Verify that the user is redirected to the PromptPay page
    expect(page).to have_current_path(promptpay_path, wait: 20)
  end

  scenario "goes back to normal content when small bubble is clicked" do
    find("#removeThailand").click

    within('.carousel-inner') do
      expect(page).not_to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
    end
  end
end
