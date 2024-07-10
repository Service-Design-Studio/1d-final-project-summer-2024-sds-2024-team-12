And("I fill in the widget name as {string}") do |name|
  fill_in('shortcut_button_name_of_widget', with: name) # Adjust the field name based on your HTML
end

And("I should see a shortcut button called {string}") do |button_text|
  puts page.html
  expect(page).to have_selector('.iconcontainer') do |container|
    container.find('p.shortcut', text: button_text)
  end
end
