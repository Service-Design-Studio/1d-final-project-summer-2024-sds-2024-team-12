Feature: Card Limit
    Background:
    Given the following transactions exist:
        | name   | amount |
        | Nicole | 500.00 |
        | Nicole | 500.00 |

    Given a user exists with phone "12345677" and password "224466"
    And I am logged in with phone "12345677" and password "224466"


    Scenario: Prompt to change card limit 
        Given that I am on the transactions page
        When I see suggestion to change limit in the carousel 
        And I click the "Set up Limit" button
