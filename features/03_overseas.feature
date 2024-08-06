Feature: Overseas Transfer
  As a mobile banking app user who went to Thailand for vacation
  I want to transfer money to a store owner in Thailand using the PromptPay feature
  So that I can transfer money quickly using their phone number

  Background:
  Given I am logged into user with phone "12345678" and password "224466"

  Scenario: PromptPay suggestion when in Thailand
    Given that I am on the transactions page
    When I click on the Quick Action button
    Then I should see the suggestion "Consider using Promptpay"
    When I click the "Proceed to Promptpay" button
    Then I should be on the "promptpay" transaction page

  Scenario: Transferring through PromptPay
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Use PromptPay" button
    And I fill in the recipient number "123456789"
    And I fill in the amount to be transferred in SGD "500"
    And click on "NEXT" button below
    Then I should see a message saying "Transaction was successfully created."

  Scenario: Adding a new recipient, Jane for non-Prompt Pay transaction
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Proceed with DBS Remit instead" button
    Then I should see a page to "Enter Recipient's Details"
    When I fill in "bank" under recipient's bank
    Then I fill in the recipient's account number "123456"
    And I fill in the recipient's name "Jane" 
    And I fill in "123 Sample Street, Bangkok" in the registered address
    And I fill in "Bangkok" under city
    When I press next
    Then I should see that I have added a recipient
    When I click on the back button
    Then I should see the new recipient "Jane" that I added

  Scenario: Transferring $500 to Jane
    Given that I am on the overseas transfer page with a recipient "Jane"
    When I click on the recipient "Jane"
    Then I should see the overseas Transfer page
    And I fill in the amount to be transferred with "500"
    And click on "NEXT" button below
    Then I should be able to see that a new transaction was created
  
  Scenario: Wrong number of digits for recipient from Thailand
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on "Thailand"
    When I click on "Use PromptPay" button
    And I fill in the recipient number "02213"
    And I fill in the amount to be transferred in SGD "500"
    Then I press the "NEXT" button
    Then I should see an error message: "Please enter exactly 9 digits."


