Feature: Managing Transactions

    Background:
    Given a transaction exists with:
        | name     | amount    |
        | Nicole | 50.00     |


  Scenario: Making a PayNow transaction
    Given I am on the transactions page
    When I click on PayNow button
    Then I should be on the new transaction page
    When I fill in Recipient Name with "Nicole" 
    And I fill in the amount to be transferred in SGD with "50.00"
    And press the "NEXT" button
    Then I should see the message that "Transaction was successfully created"

  Scenario: Checking Transaction History
    Given I am on the transactions page 
    When I click on Transaction History
    Then I should be able to see a transaction that says "Paynow to Nicole" and "-50.00"

  Scenario: Deleting Transaction 
    Given I am on the transactions page 
    When I click on Transaction History
    Then I should be able to see a list of my past transactions
    When I click on the transaction that says "Paynow to Nicole" and "-50.00"
    And click on destroy this transaction
    Then I should see a "Transaction was successfully destroyed" message at the top


