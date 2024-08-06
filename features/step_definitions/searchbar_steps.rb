When('I enter in the searchbar: how to change limit') do
  fill_in 'search-input', with: "how to change limit\n"
end

When('I enter in the searchbar: send emily 100') do
  fill_in 'search-input', with: "send emily 100\n"
end

When('I enter in the searchbar: send nicole 100') do
  fill_in 'search-input', with: "send nicole 100\n"
end

Then('I should see a popup asking me to add the recipient') do
  using_wait_time 5 do
    expect(page).to have_selector('#no-contact-modal', visible: true)
  end
end

Then('I should see a popup saying it will lead to the paynow page') do
  using_wait_time 5 do
    # Wait for the modal to appear
    expect(page).to have_selector('#confirmation-modal', visible: true)
  end
end

When('I click on yes in the popup') do
  expect(page).to have_selector('#confirmation-modal', visible: true)
  expect(page).to have_selector('#confirm-button')
  find('#confirm-button').click
  click_button('YES')
end

Then('I should be on the transaction page with the {string} and {string} autofilled') do |recipient,amount|
  expect(find_field('transaction_name').value).to eq(recipient)

  # Check that the amount field is autofilled with the expected value
  expect(find_field('transaction_amount').value).to eq(amount)
end

Then('I should be redirected to the change card limit page') do
  expect(page).to have_current_path('/cardlimit/new')
end
