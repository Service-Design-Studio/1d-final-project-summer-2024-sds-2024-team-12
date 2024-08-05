Feature: Searchbar

Background:
  Given I am logged into user with phone "12345678" and password "224466"

Scenario: Transferring money to an existing recipient
  Given I am on the transactions page
  When I type "send nicole 100" into the search bar
  And I click on the search icon
  Then I should see a popup saying "Are you sure you want to paynow nicole 100 dollars?"
  When I click the "YES" button 
  Then I should be on the transactions page with the fields autofilled
  And press the "NEXT" button
  Then I should see a success page with "Successful"


Scenario: Transferring money to an unknown recipient
  Given I am on the transactions page
  When I type "send peter 100" into the search bar
  And I click on the search icon
  Then I should see a popup saying "Please add the recipient."


Scenario: Changing card limit
  Given I am on the transactions page
  When I type "how to change limit" into the search bar
  And I click on the search icon
  Then I should see a page that says "Local Transfer Limit"
