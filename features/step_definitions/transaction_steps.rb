# features/step_definitions/transaction_steps.rb

Given("a transaction exists with:") do |table|
  transaction_data = table.hashes.first
  Transaction.create!(
    name: transaction_data['name'],
    amount: transaction_data['amount'].to_d,
    created_at: Time.current,
    updated_at: Time.current
  )
end

Given("I am on the transactions page") do
  visit transactions_path
end

When("I click on PayNow button") do
  find('#paynowbutton a').click
end


Then("I should be on the new transaction page") do
  expect(page.current_path).to eq(new_transaction_path)
end


When("I fill in Recipient Name with {string}") do |transaction_name|
  fill_in("transaction_name", with: transaction_name)
end

And("I fill in the amount to be transferred in SGD with {string}") do |transaction_amount|
  fill_in("transaction_amount", with: transaction_amount)
end

When("press the {string} button") do |button_text|
  click_on button_text
end

Then("I should see the message that {string}") do |success_message|
  expect(page).to have_content(success_message)
end

Then("I should be able to see a transaction that says {string} and {string}") do |transaction_name, amount|
  # Find the link containing the transaction details
  within('a[href="/transactions/1"]') do  # Update the href attribute as per your specific scenario
    expect(page).to have_css('.transaction-name', text: 'Paynow to Nicole')
    expect(page).to have_css('.money', text: amount)
  end
end


When("I click on Transaction History") do
  find('#history a').click
end

Then("I should be able to see a list of my past transactions") do
  expect(page).to have_current_path("/transaction_history")
end

When("I click on the transaction that says {string} and {string}") do |transaction_name, amount|
  # Find the link containing the transaction details
  transaction = find('a', text: transaction_name)
  within(transaction) do
    find('.money', text: amount).click
  end
end


And("click on destroy this transaction") do
  find('form.button_to', wait: 10).click_button('Destroy this transaction')
end

Then("I should see a {string} message at the top") do |success_message|
  expect(page).to have_content(success_message)
end
