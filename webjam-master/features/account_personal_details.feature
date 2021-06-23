Feature: Updating your account details

  In order to show the world how cool I am
  I should be able to edit and update my personal details
  
  Scenario: viewing the account page
    Given I am logged in
    When I view the account page
    Then I see the page

  Scenario: updating account details
    Given I am logged in
    When I update my account details
    Then my account details are updated
    And I am redirected to the account page

  Scenario: updating account details with invalid details
    Given I am logged in
    When I update my account details giving invalid details
    Then my account details aren't updated
    And I am shown the account edit page