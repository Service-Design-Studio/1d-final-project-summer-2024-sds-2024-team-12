Feature: Overseas Transfer
  As a mobile banking app user who went to Thailand for vacation
  I want to transfer money to a store owner in Thailand using the PromptPay feature
  So that I can transfer money quickly using their phone number

  Background:
  Given a user exists with phone "12345677" and password "224466"
  And I am logged in with phone "12345677" and password "224466"

  Scenario: Adding a new recipient, Jane for non-Prompt Pay transaction
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Proceed without PromptPay" button
    And I fill in "123456789" in the recipient account details
    And I fill in the recipient name, "Jane Tan" 
    And I fill in "123 Sample Street, Bangkok, Thailand" in the registered address
    When I press next
    Then I should see that I have added a recipient
    When I click on the back button
    Then I should see the new recipient "Jane Tan" that I added

  Scenario: Transferring $500 to Jane
    Given that I am on the overseas transfer page with a recipient "Jane Tan"
    When I click on the recipient "Jane Tan"
    Then I should see the overseas Transfer page
    And I fill in the amount to be transferred with "500"
    And click on "TRANSFER NOW" button below
    Then I should be able to see that a new transaction was created

  Scenario: Transferring through PromptPay
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Use PromptPay" button
    And I fill in the recipient number "02-2134567"
    And I fill in the amount to be transferred in SGD "500"
    Then I press the "NEXT" button
    Then I should see a message saying "Transaction was successfully created."
  
  Scenario: Wrong number of digits for recipient from Thailand
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Use PromptPay" button
    And I fill in the recipient number "02213"
    And I fill in the amount to be transferred in SGD "500"
    Then I press the "NEXT" button
    Then I should see an error message: "Phone number must be exactly 9 digits."

  Scenario: PromptPay suggestion when in Thailand
    Given that I am on the transactions page in overseas steps
    When I click on the coconut in the bottom left
    Then I should see a suggestion for the "PromptPay feature" in the carousel
    And I click the "Go Now" button
    Then I should be on the "promptpay" transaction page
