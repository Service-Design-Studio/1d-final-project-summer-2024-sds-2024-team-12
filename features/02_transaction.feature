Feature: Managing Transactions

  Background:
  Given the following transaction exists:
      | name     | amount    |
      | 12345678 | 50.00     |
  


  Scenario: Making a PayNow transaction

    Given I am on the transactions page
    When I click on PayNow button
    Then I should be on the page to enter recipient's details
    When I fill in mobile number with "12345678"
    And press the "NEXT" button
    Then I should be on the new transaction page
    When I fill in the amount to be transferred in SGD with "50.00"
    And press the "NEXT" button
    Then I should see a success page with "Successful"

  Scenario: Checking Transaction History
    Given I am on the transactions page 
    When I click on Transaction History
    Then I should be able to see a transaction that says "Paynow to 12345678" and "-50.00"

  Scenario: Did not put amount when making a transaction
    Given I am on the transactions page
    When I click on PayNow button
    Then I should be on the page to enter recipient's details
    When I fill in mobile number with "12345678"
    And press the "NEXT" button
    Then I should be on the new transaction page
    And press the "NEXT" button
    Then I should see an error that says "How much do you want to pay?"

  
