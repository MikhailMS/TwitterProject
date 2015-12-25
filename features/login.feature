Feature: Login

   Scenario: Correct password entered
     #Then I should see "Log into the system"
     Given I am on login_page
     When I fill in "email" with "admin"
     When I fill in "password" with "123456"
     When I press "bttnLogin" within "form"
     Then I should see "Home"

   Scenario: Invalid password entered
     Given I am on login_page
     When I fill in "email" with "admin"
     When I fill in "password" with "1232134"
     When I press "bttnLogin" within "form"
     Then I should see "Incorrect email or password"

  Scenario: Invalid email entered
    Given I am on login_page
    When I fill in "email" with "admin123123"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Incorrect email or password"

  Scenario: Trying to get to the homepage without logging in
    Given I am on the homepage
    Then I should be on login_page

  Scenario: Trying to get to the search page without logging in
    Given I am on the search page
    Then I should be on login_page