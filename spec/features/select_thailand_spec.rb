require 'rails_helper'

RSpec.feature "Selecting Thailand", type: :feature, js: true do
    scenario "User selects Thailand and sees PromptPay modal" do  
        visit overseas_transfer_select_location_path
        click_link 'Thailand'
        expect(page).to have_selector('#promptPayModal', visible: true)
        expect(page).to have_text('You are sending money to Thailand, would you want to use our PromptPay feature to send money to Thailand more conveniently?')
    end

    scenario "User selects United Kingdom and does not see the PromptPay modal" do
        visit overseas_transfer_select_location_path
        click_link 'United Kingdom'
        expect(page).to have_no_css('#promptPayModal', visible: true)
    end

    scenario "User selects PromptPay option after selecting Thailand" do
        visit overseas_transfer_select_location_path
        click_link 'Thailand'
        within('#promptPayModal') do
            click_link 'Use PromptPay'
        end
        expect(page).to have_current_path(promptpay_path)
    end

    scenario "User able to use PromptPay successfully" do
        visit promptpay_path
        fill_in 'Recipient Number', with: '123456789'
        fill_in 'sgdAmount', with: '100'
        click_button 'NEXT'
        # Assuming the redirection URL follows the pattern /transactions/:id
        expect(page).to have_current_path(/transactions\/\d+/, wait: 10)  # Waits up to 10 seconds  
    end

    scenario "User not able to use PromptPay successfully" do
        visit promptpay_path
        fill_in 'Recipient Number', with: '1234567'
        fill_in 'sgdAmount', with: '100'
        click_button 'NEXT'
        expect(current_path).to eq(promptpay_path) # Assumes promptpay_path is the current path
    end

    scenario "User rejects PromptPay option after selecting Thailand" do
        visit overseas_transfer_select_location_path
        click_link 'Thailand'
        within('#promptPayModal') do
            click_link 'Proceed without PromptPay'
        end
        expect(page).to have_current_path(overseas_transfer_new_recipient_path(country: 'Thailand'))
    end

end