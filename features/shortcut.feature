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
        When I see suggestions in the carousel
        And I click the "Set up" button
        When I click on "Make a Quick Shortcut" button in the popup
        And I fill in the widget name as "Nic100"
        And I press the "Create Shortcut Button" button
        Then I should see a message saying "Shortcut button was successfully created."
        When I navigate to the "Pay & Transfer" page
        Then I should see a shortcut button called "Nic100" 

    Scenario: Using the Quick Shortcut
        Given that I am on the pay & transfer page
        When I click on the quick shortcut I made called "Nic100"
        And press the "NEXT" button
        Then I should see the message that "Transaction was successfully created"

    Scenario: Deleting the Quick Shortcut    
        Given that I am on the pay & transfer page
        Then I click the "Delete" button
        And I should not see a shortcut button "Nic100"
        Then I should see a message saying "Shortcut was successfully deleted."



