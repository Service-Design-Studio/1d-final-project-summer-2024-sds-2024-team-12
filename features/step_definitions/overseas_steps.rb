Given("that I am on the transactions page") do
  visit transactions_path
end

Given("that I am on the homepage") do
  visit root_path
end

When("I click on {string}") do |link_text|
  click_link link_text
end

When("I click {string}") do |button_text|
  click_button button_text
end

When("I click on the recipient") do
  # Assuming recipient is in a list, find by specific selector
  find('.recipient-list .recipient', text: 'John Doe').click
end

Then("I should see {string}") do |text|
  expect(page).to have_content(text)
end

Then("I should see the overseas Transfer page") do
  expect(page).to have_content("Overseas Transfer")
end

When("I fill in the recipient account details") do
  fill_in "account_number", with: "123456789"
  fill_in "bank_name", with: "Sample Bank"
  fill_in "swift_code", with: "SWIFT123"
end

When("I fill in the recipient name and registered address") do
  fill_in "recipient_name", with: "John Doe"
  fill_in "registered_address", with: "123 Sample Street, Bangkok, Thailand"
end

Then("I click on {string}") do |country|
  find('button', text: country).click
end

And("I press {string}") do |button_text|
  click_button button_text
end

Then("I click the button {string}") do |button_text|
  click_button button_text
end

Given("the recipient {string} exists") do |recipient_name|
  # Implement logic to ensure recipient exists in the database
  @recipient = Recipient.find_by(name: recipient_name)
  raise "Recipient #{recipient_name} not found" unless @recipient
end

When("I fill in the amount to be sent (in SGD)") do
  fill_in "amount", with: "1000"
end

And("click on {string}") do |button_text|
  click_button button_text
end

Then("I should be able to see that a new transaction was created") do
  expect(page).to have_content("Transaction was successfully created")
end
