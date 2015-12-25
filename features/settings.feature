Feature: Settings

  Scenario: Admin login
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    Then I should be on settings page
    Then I should see "admin's Settings"
    Then I should see "Admin Settings"
    Then I should see "Create New Account:"
    Then I should see "Set Account Permissions:"
    Then I should see "Clear Searches:"
    Then I should see "User Settings"
    Then I should see "Change Account Password:"

  Scenario: User login (no admin settings visible)
    Given I am on login_page
    When I fill in "email" with "mlister252"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    Then I should be on settings page
    Then I should see "mlister252's Settings"
    Then I should not see "Admin Settings"
    Then I should not see "Create New Account:"
    Then I should not see "Set Account Permissions:"
    Then I should not see "Clear Searches:"
    Then I should see "User Settings"
    Then I should see "Change Account Password:"

  Scenario: Add new user
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "accountName" with "newAccount4"
    When I fill in "accountPassword" with "12345678"
    When I press "submit" within ".newAccount"
    #Then I should see "New account added"
    When I follow "Logout"
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"

  Scenario: Change user permissions from user to admin
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "accountName_Per" with "newAccount4"
    When I choose "adminRadio"
    When I press "submit" within ".updatePermission"
    When I follow "Logout"
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    Then I should see "Admin Settings"

  Scenario: Change user permissions from admin to user
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "accountName_Per" with "newAccount4"
    When I choose "userRadio"
    When I press "submit" within ".updatePermission"
    When I follow "Logout"
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    Then I should not see "Admin Settings"

  Scenario: Change password
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "passOld" with "12345678"
    When I fill in "passNew" with "password"
    When I fill in "passNew2" with "password"
    When I press "submit" within ".newPassword"
    When I follow "Logout"
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "password"
    When I press "bttnLogin" within "form"
    Then I should see "Home"

  Scenario: Change password back
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "password"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "passOld" with "password"
    When I fill in "passNew" with "12345678"
    When I fill in "passNew2" with "12345678"
    When I press "submit" within ".newPassword"
    When I follow "Logout"
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"

  Scenario: Change password with one field wrong
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "12345678"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "passOld" with "12345678"
    When I fill in "passNew" with "password"
    When I fill in "passNew2" with "passwor"
    When I press "submit" within ".newPassword"
    Then I should see "Your new password doesn't match itself in one of the fields."

  Scenario: Try to login with password you used to replace your old password and saw an error.
    Given I am on login_page
    When I fill in "email" with "newAccount4"
    When I fill in "password" with "password"
    When I press "bttnLogin" within "form"
    Then I should see "Incorrect email or password"

  Scenario: Delete user from the system(admin feature)
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "userToDelete" with "newAccount2"
    When I press "submit" within ".deleteUsers"
    Then I should see "You successfully deleted user: newAccount2."

  Scenario: Try to login with as user who was deleted.
    Given I am on login_page
    When I fill in "email" with "newAccount2"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Incorrect email or password"

  Scenario: Try to delete user(admin feature) which is not presented in system
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "userToDelete" with "macBook"
    When I press "submit" within ".deleteUsers"
    Then I should see "User does not exist."

  Scenario: Try to delete user, you currently login as.
    Given I am on login_page
    When I fill in "email" with "admin"
    When I fill in "password" with "123456"
    When I press "bttnLogin" within "form"
    Then I should see "Home"
    When I follow "Settings"
    When I fill in "userToDelete" with "admin"
    When I press "submit" within ".deleteUsers"
    Then I should see "You cannot delete the current account!"