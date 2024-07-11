require 'rails_helper'

RSpec.describe "Card Limit", type: :feature, js: true do
  let!(:transactions) do
    [
      Transaction.create(name: "Nicole", amount: 500.00),
      Transaction.create(name: "Nicole", amount: 500.00)
    ]
  end

  before do
    visit transactions_path
  end

  scenario "Prompt to change card limit" do
    within('.carousel-inner', wait: 20) do
      # Ensure the carousel has loaded and contains the expected item
      expect(page).to have_css('.carousel-caption p.textheader', text: 'Suggestion:')

      suggestions_item = find('.item', text: 'Your card usage is nearing $500. Consider setting up a card limit to manage your spending:')

      within(suggestions_item) do
        expect(page).to have_content('Your card usage is nearing')
        click_link('Set up Limit')
      end
    end

    # Verify that the user is redirected to the card limit setup page
    expect(current_path).to eq(new_cardlimit_path)
  end
end
