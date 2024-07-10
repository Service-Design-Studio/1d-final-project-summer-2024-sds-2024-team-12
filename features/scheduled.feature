Feature: Scheduled Transaction
    Background:
    Given the following transactions exist:
        | name   | amount |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
        | Nicole | 100.00 |

    Scenario: Set a scheduled transaction at the start of every month
        Given that I am on the transactions page
        When I see suggestions in the carousel
        And I click the "Set up" button
        Then I should see a popup with 2 buttons
        And when I click "Schedule Payment"
        Then I should see the new Scheduled Transaction page
        When I fill in the recipient name
        And fill in the amount to be transferred in SGD
        And click on the calendar icon
        Then I can fill in the next date for the scheduled transaction
        And I can choose the frequency of the scheduled transaction by selecting "Monthly"
        Then I click the button "Save" at the bottom
