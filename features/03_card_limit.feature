Feature: Card Limit
    Background:
    Given the following transaction exists:
        |   name   | amount |
        | 12345678 | 500.00 |


    Scenario: Prompt to change card limit 
        Given that I am on the transactions page
        When I click on the Quick Action button
        Then I should see the suggestion "Consider increasing your card limit to manage your spending"
        When I click the "Change my card limit" button
        Then I should see a page that says "Local Transfer Limit"
