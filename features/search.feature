Feature: Search

  Scenario: Able to get to search page from homepage
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page

  Scenario: Not able to see search page whilst not logged in
    Given I am on the search page
    Then I should not see "Custom Twitter Search"
    Then I should be on login_page

  Scenario: Able to search with 5 per page
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page
    When I fill in "search" with "hello"
    When I choose "radioInput5"
    Then I press "submit"
    Then I should see "1" within "table"
    Then I should see "5" within "table"
    Then I should see "6" rows

  Scenario: Able to search with 10 per page
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page
    When I fill in "search" with "hello"
    When I choose "radioInput10"
    Then I press "submit"
    Then I should see "1" within "table"
    Then I should see "11" rows

  Scenario: Able to search with 20 per page
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page
    When I fill in "search" with "hello"
    When I choose "radioInput20"
    Then I press "submit"
    Then I should see "1" within "table"
    Then I should see "20" within "table"
    Then I should see "21" rows

  Scenario: Not able to see page navigation buttons without searching
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page
    Then I should not see "Next"
    Then I should not see "Prev"

  Scenario: Able to see next page button after searching
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Search"
    Then I should be on the search page
    Then I should not see "next"
    Then I should not see "previous"
    When I fill in "search" with "test search"
    When I choose "radioInput10"
    Then I press "submit"
    Then I should see "Next"
    Then I should not see "Prev"

  Scenario: Able to see next and previous page button after searching then going to page 2
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    Given I am on test search 2nd page
    Then I should see "Next" within ".pageNav"
    Then I should see "Prev" within ".pageNav"

  Scenario: Not able to see Next button on last page of tweets
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    Given I am on test search last page
    Then I should not see "Next" within ".pageNav"
    Then I should see "Prev" within ".pageNav"

  Scenario: Searching an empty string gives an error message
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    Given I am on the search page
    Then I press "submit"
    Then I should see "There is no search query"

  Scenario: Searching a new search string should make this string appear on the home page
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    Given I am on the search page
    When I fill in "search" with "test search 50"
    Then I press "submit"
    Given I am on the home page
    Then I should see "test search 50"


