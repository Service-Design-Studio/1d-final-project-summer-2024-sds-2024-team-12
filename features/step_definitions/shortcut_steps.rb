And("I fill in the widget name as {string}") do |name|
  fill_in('shortcut_nickname', with: name) # Adjust the field name based on your HTML
end

And("I should see a shortcut button called {string}") do |button_text|
  expect(page).to have_selector('a', text: button_text)
end

Given("that I am on the pay & transfer page") do
  visit '/pay_and_transfer_page/index'
end

Given("the following shortcut exists:") do |table|
  shortcuts_data = table.hashes.first
  user = User.find_by(phone: '12345678')

  Shortcut.create!(
    nickname: shortcuts_data['nickname'],
    recipient_name: shortcuts_data['recipient_name'],
    amount: shortcuts_data['amount'].to_d,
    user_id: user.id,
    widget_type: shortcuts_data['widget_type'] || 'default', # Default value if widget_type is not provided
    created_at: Time.current,
    updated_at: Time.current
  )
end


And("I should not see a shortcut button {string}") do |button_text|
  expect(page).not_to have_css('a[href*="/transactions/new"] .sciconcontainer') do |a|
    expect(a).not_to have_css('.scicons', text: button_text)
  end
end

When("I click on the quick shortcut I made called {string}") do |name|
  click_link(name)
end

When('I navigate to the "Pay & Transfer" page') do
  # Click the button that contains the text "Pay & Transfer"
  click_on('Pay & Transfer')
end
