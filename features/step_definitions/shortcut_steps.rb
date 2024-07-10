And("I fill in the widget name as {string}") do |name|
  fill_in('shortcut_button_name_of_widget', with: name) # Adjust the field name based on your HTML
end

And("I should see a shortcut button called {string}") do |button_text|
  expect(page).to have_selector('.iconcontainer') do |container|
    container.find('p.shortcut', text: button_text)
  end
end

And(/^I am logged in with phone "(.*?)" and password "(.*?)"$/) do |phone, password|
  visit sign_in_path
  fill_in 'phone', with: phone
  fill_in 'password', with: password
  click_button 'Sign In'
end

And("I have an existing quick shortcut with the name {string}") do |name|
  visit new_shortcut_button_path
  fill_in('shortcut_button_name_of_widget', with: name) # Adjust the field name based on your HTML
  click_on("Set up")
end

When("When I click on the quick shortcut I made") do
  find('div.iconcontainer a[href*="/transactions/new"]').click
end
