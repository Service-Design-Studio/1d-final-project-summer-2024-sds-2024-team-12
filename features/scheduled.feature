Feature: Scheduled Transaction
    As a mother who pays monthly allowance to her children
    I want to set up monthly scheduled payments to my children at the start of the month
    So that I no longer need to manually create a transaction every month

    Background:
    Given the following transactions exist:
        | name   | amount |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
        | Nicole | 100.00 |
    Given a user exists with phone "12345677" and password "224466"
    And I am logged in with phone "12345677" and password "224466"


    Scenario: Set a scheduled transaction at the start of every month
        Given that I am on the transactions page
        When I see suggestions in the carousel
        And I click the "Set up" button
        When I click on "Schedule Payment" button in the popup
        Then I should see the new Scheduled Transaction page
        When I fill in the recipient name
        And fill in the amount to be transferred in SGD
        And click on the calendar icon
        Then I can fill in the next date for the scheduled transaction
        And I can choose the frequency of the scheduled transaction by selecting "Monthly"
        Then I click the button "Save" at the bottom
