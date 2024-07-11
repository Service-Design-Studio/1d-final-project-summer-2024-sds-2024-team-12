require 'rails_helper'

RSpec.describe "Interaction with the coconut button", type: :feature, js: true do
  before do
    visit transactions_path # Adjust to your actual path
  end

  scenario "updates the carousel to show Thailand-specific content when the coconut button is clicked" do
    # Assuming clicking the button sets something in the session
    find("#thailandButton").click

    # Optional: verify that the Thailand slide is now part of the carousel's inner content
    within('.carousel-inner') do
      expect(page).to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
    end
  end

  scenario "goes back to normal content when small bubble is clicked" do
    find("#removeThailand").click

    within('.carousel-inner') do
      expect(page).not_to have_text('You are in Thailand now, do you want to try our PromptPay feature?', wait: 20)
    end
  end
end
