Feature: Quick Shortcut
    Background:
    Given the following transactions exist:
        | name   | amount |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
        | Nicole | 100.00 |

    Scenario: Set a scheduled transaction at the start of every month
        Given a user exists with phone "12345677" and password "224466"
        Given that I am on the transactions page
        When I see suggestions in the carousel
        And I click the "Set up" button
        When I click on "Make a Quick Shortcut" button in the popup
        And I fill in the widget name as "Nicole $100"
        Then I press the "Create Shortcut Button" button
        Then I should see a message saying "Shortcut button was successfully created."
        And I should see a shortcut button called "Nicole $100" 