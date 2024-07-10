Feature: Overseas Transfer

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

  Scenario: Transferring $1000 to Jane
    Given that I am on the overseas transfer page with a recipient "Jane Tan"
    When I click on the recipient "Jane Tan"
    Then I should see the overseas Transfer page
    And I fill in the amount to be transferred with "1000"
    And click on "TRANSFER NOW" button below
    Then I should be able to see that a new transaction was created
