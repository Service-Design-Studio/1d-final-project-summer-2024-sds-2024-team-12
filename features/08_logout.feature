Feature: User Logout

  @use_existing_user
  Scenario: Logout from existing account
    Given a user exists with phone "12345678" and password "224466"
    And I am on the login page
    When I login with my phone number "12345678"
    And I fill in my PIN with "224466"
    When I press Sign In
    Then I should see the transactions page
    When I click the Logout button
    Then I should go back to the Sign in page