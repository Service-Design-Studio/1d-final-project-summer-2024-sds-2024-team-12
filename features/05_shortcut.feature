Feature: Quick Shortcut
    As a mother who pays monthly allowance to her children
    I want to set up quick shortcuts to pay my children their allowance  
    So that I can save time and avoid manually entering the user and amount every month

    Background:
    Given the following transactions exists:
        | name     | amount |
        | 12345678 | 20.00 |
        | 12345678 | 20.00 |
        | 12345678 | 20.00 |

    Given the following shortcut exists:
        |  nickname  | recipient_name |amount | 
        | Nic100     |  12345678      | 20.00 |

    Scenario: Create a Quick Shortcut
        Given that I am on the transactions page
        When I click on the Quick Action button
        Then I should see the suggestion "We noticed you paid 12345678"
        When I click the "Make a Quick Shortcut" button
        And I fill in the widget name as "Nic100"
        And I press the create quick shortcut button
        When I am on the Pay & Transfer page
        Then I should see a shortcut button called "Nic100" 

    Scenario: Using the Quick Shortcut
        Given that I am on the pay & transfer page
        When I click on the quick shortcut I made called "Nic100"
        And press the "NEXT" button

    Scenario: Deleting the Quick Shortcut    
        Given that I am on the pay & transfer page
        Then I click the "Delete" button
        And I should not see a shortcut button "Nic100"



