Feature: Viewing the home page

  In order to see all the cool stuff
  I should be able to visit the home page
  
  Scenario: not logged in
    Given I am not logged in
    When I view the home page
    Then I see the page

  Scenario: viewing / on a mobile
    Given I am not logged in
    When I view the home page from an iphone
    Then I am redirected to the mobile page
    
  Scenario: viewing / on a mobile with redirect-to-mobile=no
    Given I am not logged in
    When I view the home page from an iphone specifying redirect-to-mobile=no
    Then I am not redirected to the mobile page
    And I see the page

  Scenario: viewing the mobile version with an upcoming event, a past event and a post
    Given I am not logged in
      And there is an upcoming event
      And there is a past event
      And there is a post
    When I view the mobile version of the home page
    Then I see the page

  Scenario: viewing the mobile version without any events or posts
    Given I am not logged in
    When I view the mobile version of the home page
    Then I see the page
