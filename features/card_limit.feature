Feature: Card Limit
    Background:
    Given the following transaction exists:
        |   name   | amount |
        | 12345678 | 500.00 |


    Scenario: Prompt to change card limit 
        Given that I am on the transactions page
        When I see suggestion to change limit in the carousel 
        And I click the Set Up Limit button
        Then I should see a page that says "Local Transfer Limit"
