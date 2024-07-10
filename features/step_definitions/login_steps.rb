Given('I am on the login page') do
  visit sign_in_path
end

When("I click on Sign Up") do
  click_on("Sign Up")  # Adjust the selector as per your application's actual button
end

When('I fill in {string} with {string}') do |field, value|
  fill_in field, with: value
end

When('I fill in Phone with {string}') do |phone|
  fill_in 'Phone', with: phone
end

When("I press Sign Up") do
  click_button("Sign Up")  # Adjust the selector as per your application's actual button
end

Then("I should see that I successfully created an account") do
  expect(page).to have_content("Successfully created account.")
end


When("I press Sign In") do
  click_button("Sign In")  # Adjust the selector as per your application's actual button
end

Then('I should see the transactions page') do
  expect(current_path).to eq(transactions_path)
end

Given('a user exists with phone {string} and password {string}') do |phone, password|
  # Create the user if it doesn't already exist
  User.find_or_create_by(phone: phone) do |user|
    user.password = password
    user.password_confirmation = password
  end
end
