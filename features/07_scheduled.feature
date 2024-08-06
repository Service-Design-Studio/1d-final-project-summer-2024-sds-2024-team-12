Feature: Scheduled Transaction
    As a mother who pays monthly allowance to her children
    I want to set up monthly scheduled payments to my children at the start of the month
    So that I no longer need to manually create a transaction every month

    Background:
    Given the following transactions exists:
        | name     | amount |
        | 12345678 | 20.00 |
        | 12345678 | 20.00 |
        | 12345678 | 20.00 |

    Given the following scheduled transaction exists:
        |  name  | amount | start_date  | frequency |
        |12345678|  20.00 | 2024-07-25  |   Monthly |


    Scenario: Set a scheduled transaction at the start of every month
        Given that I am on the transactions page
        When I click on the Quick Action button
        Then I should see the suggestion "We noticed you paid 12345678"
        When I click the "Schedule Payment" button
        Then I should see the new "Scheduled Payment" page
        When I fill in the recipient name
        And fill in the amount to be transferred in SGD
        And I fill in the start date with "2024-07-25"
        And I can choose the frequency of the scheduled transaction to be "Monthly"
        And I click the button Save at the bottom
        Then I should be redirected to the homepage


    Scenario: Checking for scheduled transactions under Scheduled Transacations
        Given that I am on the transactions page
        When I click on transfers scheduled button
        Then I should see the scheduled payment that I made with the correct name "12345678"

    Scenario: Deleting scheduled transactions under Scheduled Transacations
        Given that I am on the transactions page 
        When I click on transfers scheduled button
        Then I should see the scheduled payment that I made with the correct name "12345678"
        And I click the "Delete Scheduled Payment" button
        Then I should no longer see the scheduled transaction with the name "12345678"

