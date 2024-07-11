And("I fill in the widget name as {string}") do |name|
  fill_in('shortcut_button_nickname', with: name) # Adjust the field name based on your HTML
end

And("I should see a shortcut button called {string}") do |button_text|
  expect(page).to have_css('a[href*="/transactions/new"]') do |a|
    # Check for the content inside the div with class 'scicons'
    expect(a).to have_css('.scicons', text: button_text)
  end
end

And(/^I am logged in with phone "(.*?)" and password "(.*?)"$/) do |phone, password|
  visit sign_in_path
  fill_in 'phone', with: phone
  fill_in 'password', with: password
  click_button 'Sign In'
end

And("I have an existing quick shortcut with the name {string}") do |name|
  click_on("Set up")
  find('#popup0',  :visible => false)
  within('#popup0') do
    click_link("Make a Quick Shortcut")
  end
  fill_in('shortcut_button_nickname', with: name) # Adjust the field name based on your HTML
  click_button("Create Shortcut Button")
end

And("I should not see a shortcut button {string}") do |button_text|
  expect(page).not_to have_css('a[href*="/transactions/new"] .sciconcontainer') do |a|
    expect(a).not_to have_css('.scicons', text: button_text)
  end
end

When("I click on the quick shortcut I made called {string}") do |name|
  click_link(name)
end
