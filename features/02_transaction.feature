Feature: Managing Transactions

    Background:
    Given a transaction exists with:
        | name     | amount    |
        | Nicole | 50.00     |
    Given a user exists with phone "12345677" and password "224466"
    And I am logged in with phone "12345677" and password "224466"


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


  Scenario: Did not put name when making a transaction
    Given I am on the transactions page
    When I click on PayNow button
    Then I should be on the new transaction page
    And I fill in the amount to be transferred in SGD with "50.00"
    And press the "NEXT" button
    Then I should see an error that says "Name can't be blank"

  
  Scenario: Editing Transaction
    Given I am on the transactions page 
    When I click on Transaction History
    Then I should be able to see a list of my past transactions
    When I click on the transaction that says "Paynow to Nicole" and "-50.00"
    And click on "Edit this transaction"
    And I fill in the amount to be transferred in SGD with "30"
    And press the "NEXT" button
    Then I should see a "Transaction was successfully updated." message at the top

  
  Scenario: Deleting Transaction 
    Given I am on the transactions page 
    When I click on Transaction History
    Then I should be able to see a list of my past transactions
    When I click on the transaction that says "Paynow to Nicole" and "-50.00"
    And click on "Destroy this transaction"
    Then I should see a "Transaction was successfully destroyed" message at the top

