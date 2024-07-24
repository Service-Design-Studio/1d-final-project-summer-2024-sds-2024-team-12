# features/step_definitions/transaction_steps.rb

# features/step_definitions/transaction_steps.rb
Given("a transaction exists with:") do |table|
  phone = '12345677' # Replace with the actual phone number for the user
  password = '224466' # Replace with the actual password for the user

  visit sign_up_path
  fill_in 'user_phone', with: phone
  fill_in 'user_password', with: password
  fill_in 'user_password_confirmation', with:password
  click_button 'Sign Up'

  transaction_data = table.hashes.first
  user = User.find_by(phone: phone)
  raise "User not found" unless user

  Transaction.create!(
    name: transaction_data['name'],
    amount: transaction_data['amount'].to_d,
    created_at: Time.current,
    updated_at: Time.current,
    user_id: user.id
  )
end


Given("I am on the transactions page") do
  visit transactions_path
end

When("I click on PayNow button") do
  find('#paynowbutton a').click
end

Then("I should be on the page to enter recipient's details") do
  expect(page.current_path).to eq(enter_transaction_path)
end

When("I fill in mobile number with {string}") do |number|
  fill_in("mobile_number", with: number)
end

Then("I should be on the new transaction page") do
  expect(page.current_path).to eq(new_transaction_path)
end

When("I fill in Recipient Name with {string}") do |transaction_name|
  fill_in("transaction_name", with: transaction_name)
end

When("I fill in the amount to be transferred in SGD with {string}") do |transaction_amount|
  fill_in("transaction_amount", with: transaction_amount)
end

When("press the {string} button") do |button_text|
  click_on button_text
end

Then("I should see the message that {string}") do |success_message|
  expect(page).to have_content(success_message)
end

Then("I should see an error that says {string}") do |error|
  expect(page).to have_content(error)
end


Then("I should be able to see a transaction that says {string} and {string}") do |transaction_name, amount|
  # Find the link containing the transaction details
  within('a[href="/transactions/1"]') do  # Update the href attribute as per your specific scenario
    expect(page).to have_css('.transaction-name', text: transaction_name)
    expect(page).to have_css('.moneyhistory', text: amount)
  end
end


When("I click on Transaction History") do
  find('#history a').click
end


# features/step_definitions/web_steps.rb or appropriate step definition file

When("I click on the transaction that says {string} and {string}") do |transaction_name, amount|
  # Find the link containing the transaction details based on transaction_name
  transaction_link = find('a', text: transaction_name)

  # Click on the transaction link
  transaction_link.click

  # Optionally, you can output the HTML of the page for debugging
end


And("click on {string}") do |button|
  click_button(button)
end

Then("I should see a {string} message at the top") do |success_message|
  expect(page).to have_content(success_message)
end
