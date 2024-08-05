When('I type {string} into the search bar') do |search_query|
  fill_in 'search-input', with: search_query
end

And('I press Enter') do
  find('#search-input').send_keys(:enter) # Replace 'search-input' with the actual ID or selector of your input field
end

And('I click on the search icon') do
  find('#search-icon').click
end

Then('I should see a popup saying {string}') do |expected_text|
  expect(page).to have_selector('#no-contact-message', text: expected_text)
end
