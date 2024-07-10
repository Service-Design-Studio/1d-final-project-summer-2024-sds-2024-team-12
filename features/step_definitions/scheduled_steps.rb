Given("the following transactions exist:") do |table|
  table.hashes.each do |hash|
    Transaction.create(hash)
  end
end

Given("that I am on the transactions page") do
  visit transactions_path
end

When("I see suggestions in the carousel") do
  within('.carousel-inner') do
    carousel_items = all('.item')

    suggestions_item = carousel_items.find do |item|
      item.has_css?('.carousel-caption p.textheader', text: 'Suggestion:')
    end

    if suggestions_item
      # Perform your assertions or actions here
      within(suggestions_item) do
        expect(page).to have_css('.carousel-caption p.textheader', text: 'Suggestion:')
        expect(page).to have_content('Based on your frequent transactions')
      end
    else
      raise "No carousel item with suggestion found"
    end
  end
end



And("I click the {string} button") do |button_name|
  click_on(button_name)
end

Then("I should see a popup with 2 buttons") do
  within('.popup') do
    expect(page).to have_selector('.button', count: 2)
  end
end

When("I click {string}") do |button_name|
  click_on(button_name)
end

Then("I should see the new Scheduled Transaction page") do
  expect(page).to have_content('New Scheduled Transaction')
end

When("I fill in the recipient name") do
  fill_in('recipient_name', with: 'Nicole') # Adjust the field name based on your HTML
end

And("fill in the amount to be transferred in SGD") do
  fill_in('amount', with: '100') # Adjust the field name based on your HTML
end

And("click on the calendar icon") do
  find('.calendar-icon').click # Adjust the selector based on your UI
end

Then("I can fill in the next date for the scheduled transaction") do
  fill_in('next_date', with: '2024-08-01') # Adjust based on your calendar component
end

And("I can choose the frequency of the scheduled transaction by selecting {string}") do |frequency|
  select(frequency, from: 'frequency') # Adjust the select field based on your UI
end

And('click the option "Every 1 Month on Day 1" to send money on the 1st of every month') do
  choose('every_month_on_day_1') # Adjust based on your radio button or checkbox
end

Then('I click the button "Save" at the bottom') do
  click_on('Save') # Adjust based on your UI
end


def pause_carousel
  # Execute JavaScript to stop the carousel rotation
  page.execute_script("$('.carousel').carousel('pause');")
end
