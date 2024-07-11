require 'rails_helper'

RSpec.describe "Scheduled Transaction", type: :feature, js: true do
  let!(:transactions) do
    [
      Transaction.create(name: "Nicole", amount: 100.00),
      Transaction.create(name: "Nicole", amount: 100.00),
      Transaction.create(name: "Nicole", amount: 100.00)
    ]
  end

  before do
    visit transactions_path
  end

  scenario "Set a scheduled transaction at the start of every month" do
    within('.carousel-inner', wait: 20) do
      carousel_items = all('.item')

      suggestions_item = carousel_items.find do |item|
        item.has_css?('.carousel-caption p.textheader', text: 'Suggestion:')
      end

      if suggestions_item
        within(suggestions_item) do
          expect(page).to have_css('.carousel-caption p.textheader', text: 'Suggestion:')
          expect(page).to have_content('Based on your frequent transactions')
        end
      else
        raise "No carousel item with suggestion found"
      end
    end

    click_on('Set up') # Ensure this matches the button text in your HTML

    find('#popup', visible: false)
    within('#popup') do
      click_link('Schedule Payment')
    end

    expect(page).to have_content('New Scheduled Transaction')

    fill_in('name', with: 'Nicole') # Adjust the field name based on your HTML
    fill_in('amount', with: '100') # Adjust the field name based on your HTML

    find('#button').click
    fill_in('next_date', with: '2024-08-01') # Adjust based on your calendar component

    select('Monthly', from: 'frequency') # Adjust the select field based on your UI
    choose('every_month_on_day_1') # Adjust based on your radio button or checkbox

    click_on('Save') # Adjust based on your UI

    expect(page).to have_content('Scheduled transaction successfully created')
  end
end
