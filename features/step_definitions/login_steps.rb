Given('I am on the login page') do
  visit sign_in_path
end

When("I click on Sign Up") do
  click_on("Sign Up")  # Adjust the selector as per your application's actual button
end

And('I fill in phone number with {string}') do |phone|
  fill_in 'user_phone', with: phone
end

And('I fill in PIN with {string}') do |pin|
  fill_in 'user_password', with: pin
end

And('I fill in confirm pin with {string}') do |cfm_pin|
  fill_in 'user_password_confirmation', with: cfm_pin
end

When("I press Sign Up") do
  click_button("Sign Up")  # Adjust the selector as per your application's actual button
end

Then("I should see that I successfully created an account") do
  expect(page).to have_content("Successfully created account.")
end

When("I login with my phone number {string}") do |phone|
  fill_in 'phone', with: phone
end

And("I fill in my PIN with {string}") do |pin|
  fill_in 'password', with: pin
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

Given('I am logged into user with phone {string} and password {string}') do |phone, password|
  # Create the user if it doesn't already exist
  User.find_or_create_by(phone: phone) do |user|
    user.password = password
    user.password_confirmation = password
  end
  visit sign_in_path
  fill_in 'phone', with: phone
  fill_in 'password', with: password
  click_button 'Sign In'
end

When("I click the Logout button") do
  find_button('LOG OUT').click
end

Then("I should go back to the Sign in page") do
  expect(current_path).to eq(sign_in_path)
end
