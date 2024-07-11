require 'rails_helper'

RSpec.describe "User Login", type: :feature, js: true do
  let(:phone) { "12345677" }
  let(:pin) { "224466" }

  scenario "Creating an account" do
    visit sign_in_path

    click_on("Sign Up") # Adjust the selector as per your application's actual button

    fill_in 'user_phone', with: phone
    fill_in 'user_password', with: pin
    fill_in 'user_password_confirmation', with: pin

    click_button("Sign Up") # Adjust the selector as per your application's actual button

    expect(page).to have_content("Successfully created account.")
  end

  scenario "Successful login with valid credentials" do
    # Create the user if it doesn't already exist
    User.find_or_create_by(phone: phone) do |user|
      user.password = pin
      user.password_confirmation = pin
    end

    visit sign_in_path

    fill_in 'phone', with: phone
    fill_in 'password', with: pin

    click_button("Sign In") # Adjust the selector as per your application's actual button

    expect(current_path).to eq(sign_in_path)
  end
end
