Feature: Quick Shortcut
    Background:
    Given the following transactions exist:
        | name   | amount |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
    Given a user exists with phone "12345677" and password "224466"
    And I am logged in with phone "12345677" and password "224466"

    Scenario: Create a Quick Shortcut
        Given that I am on the transactions page
        When I see suggestions in the carousel
        And I click the "Set up" button
        When I click on "Make a Quick Shortcut" button in the popup
        And I fill in the widget name as "Nicole $100"
        Then I press the "Create Shortcut Button" button
        Then I should see a message saying "Shortcut button was successfully created."
        And I should see a shortcut button called "Nicole $100" 


    Scenario: Deleting the Quick Shortcut    
        Given that I am on the transactions page
        And I have an existing quick shortcut with the name "Nicole $100"
        Then I click the "Delete" button


    Scenario: Using the Quick Shortcut
        Given that I am on the transactions page
        And I have an existing quick shortcut with the name "Nicole $100"
        When I click on the quick shortcut I made
