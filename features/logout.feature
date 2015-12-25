Feature: Logout

  Scenario: Logout, should show the logged out page
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    When I follow "Logout"
    Then I should see "Logged out"
    Then I should be on logout page

  Scenario: Logout, then shouldn't be able to get back to search page without logging in
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    When I follow "Logout"
    When I go to the search page
    Then I should be on login_page