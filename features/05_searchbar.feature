Feature: Searchbar

Background:
  Given I am logged into user with phone "12345678" and password "224466"

Scenario: Transferring money to an existing recipient
  Given I am on the transactions page
  When I enter in the searchbar: send nicole 100
  Then I should see a popup saying it will lead to the paynow page
  When I click on yes in the popup 
  Then I should be on the transaction page with the "87654321" and "100" autofilled
  And I press the "NEXT" button
  Then I should see a success page with "Successful"


Scenario: Transferring money to an unknown recipient
  Given I am on the transactions page
  When I enter in the searchbar: send emily 100
  Then I should see a popup asking me to add the recipient


Scenario: Changing card limit
  Given I am on the transactions page
  When I enter in the searchbar: how to change limit
  Then I should be redirected to the change card limit page
