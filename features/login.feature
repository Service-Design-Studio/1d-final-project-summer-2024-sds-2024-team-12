Feature: User Login

  Scenario: Creating an account
    Given I am on the login page
    When I click on Sign Up
    And I fill in Phone with "12345677"
    And I fill in "Password" with "224466"
    And I fill in "Password confirmation" with "224466"
    When I press Sign Up
    Then I should see that I successfully created an account
  
  @use_existing_user
  Scenario: Successful login with valid credentials
    Given a user exists with phone "12345677" and password "224466"
    And I am on the login page
    When I fill in "Phone" with "12345677"
    And I fill in "Password" with "224466"
    When I press Sign In
    Then I should see the transactions page
