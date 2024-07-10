Feature: Overseas Transfer

  Scenario: Adding a new recipient
    Given that I am on the transactions page in overseas steps
    When I click on Overseas Transfer button
    And I click the Add Overseas Recipient button
    Then I click on Thailand
    And I fill in the recipient account details
    And I fill in the recipient name and registered address
    When I press next
    Then I should see that I have added a recipient
    And when I click on the button “Back”
    Then I should see the new recipient I added

  Scenario: Making an overseas transfer
    Given that I am on the transactions page in overseas steps
    And the recipient "Jane" exists
    When I click on “Overseas Transfer” 
    And when I click on the recipient
    Then I should see the overseas Transfer page
    When I fill in the amount to be sent (in SGD)
    And click on “Transfer Now”
    Then I should be able to see that a new transaction was created
