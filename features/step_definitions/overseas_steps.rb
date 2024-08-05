Given("that I am on the transactions page in overseas steps") do
  visit transactions_path
end

When("I click on Overseas Transfer button") do
  find('#overseasbutton a').click
end

When("I click the Add Overseas Recipient button") do
  find('.primary-button[href="/overseas_transfer/select_location"]').click
end

Then("I click on {string}") do |tcountry|
  click_link(tcountry)
end

When("I click on {string} button") do |button|
  find('#promptPayModal',  :visible => false)
  within('#promptPayModal') do
    click_link(button)
  end
end

Then("I should see a page to {string}") do |enter|
  expect(page).to have_content(enter)
end

When("I fill in {string} under recipient's bank") do |bank|
  fill_in 'bank_name', with: bank
end

Then("I fill in the recipient's account number {string}") do |account_number|
  fill_in 'account_details', with: account_number
end

And("I fill in the recipient's name {string}") do |full_name|
  fill_in 'full_name', with: full_name
end

And("I fill in {string} in the registered address") do |address|
  fill_in 'registered_address', with: address
end

And("I fill in {string} under city") do |city|
  # Assuming the city is to be filled in one of the fields with id 'account_details'
  # Ensure this is the correct field by context or additional checks
  fill_in 'city_name', with: city
end


When("I press next") do
  click_button "NEXT"
end

Then("I should see that I have added a recipient") do
  expect(page).to have_content("You have added a recipient")
end

When("I click on the back button") do
  click_link "BACK"
end

Then("I should see the new recipient {string} that I added") do |name|
  expect(page).to have_link(name) # Replace "ere" with the actual recipient text you are checking for
end

Given("that I am on the overseas transfer page with a recipient {string}") do |recipient_name|
  # Ensure the recipient exists in the database or create it if it doesn't exist
  @recipient = Recipient.find_by(full_name: recipient_name)

  unless @recipient
    @recipient = Recipient.create!(
      full_name: recipient_name,
      country: "Thailand",  # Adjust country as needed
      account_details: "123456789",
      registered_address: "123 Sample Street, Bangkok, Thailand"
    )
  end

  visit overseas_transfer_path
end

When("I click on the recipient {string}") do |name|
  click_link name
end

Then("I should see the overseas Transfer page") do
  expect(page).to have_content("Overseas Transfer")
end

When("I fill in the amount to be transferred with {string}") do |money|
  fill_in "sgdAmount", with: money  # Adjust the selector ("amount_sgd") based on your actual HTML structure
end

And("click on {string} button below") do |button_name|
  click_button(button_name)
end

Then("I should be able to see that a new transaction was created") do
  expect(page).to have_content("Transaction was successfully created")
end

And("I fill in the recipient number {string}") do |number|
  fill_in "promptpay_phone_number", with: number
end

And("I fill in the amount to be transferred in SGD {string}") do |number|
  fill_in "sgdAmount", with: number
end

Then("I press the {string} button") do |button|
  click_button(button)
end

Then("I should see a message saying {string}") do |success_message|
  expect(page).to have_content(success_message)
end

Then("I should see an error message: {string}") do |message|
  expect(page).to have_content(message)
end



Then("I should be on the {string} transaction page") do |pp|
  expected_path = "/#{pp}"
  expect(page.current_path).to eq(expected_path)
end

And("I click a button that says {string}") do |go|
  click_link(go)
end
