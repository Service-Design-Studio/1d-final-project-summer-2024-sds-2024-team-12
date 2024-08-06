
When('I click on the Quick Action button') do
  find('.fab.shadow').click
end

Then('I should see the suggestion {string}') do |expected_message|
  suggestion_tab = all('.suggestion-tabcontent.active').find do |tab|
    tab.has_content?(expected_message)
  end
end


Then('I should see a page that says {string}') do |text|
  expect(page).to have_content(text)
end

When('I return to homepage') do
  visit transactions_path
end
