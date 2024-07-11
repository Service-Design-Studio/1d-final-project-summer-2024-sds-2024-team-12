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

    scenario "User rejects PromptPay option after selecting Thailand" do
        visit overseas_transfer_select_location_path
        click_link 'Thailand'
        within('#promptPayModal') do
            click_link 'Proceed without PromptPay'
        end
        expect(page).to have_current_path(overseas_transfer_new_recipient_path(country: 'Thailand'))
    end

end