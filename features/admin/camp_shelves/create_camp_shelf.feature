Feature: Create camp shelf
  In order to organize the camp library
  As a #bookcamping admin
  I want to create a camp shelf

  Background:
    Given I'm at camp "testcamping"
    And I'm authenticated as "admin"
    And I'm an admin

  @current
  Scenario: Create a new camp shelf (using admin)
    When I go to new admin camp shelf page
    And I fill in "camp_shelf[name]" with "MyList"
    And I fill in "camp_shelf[description]" with "My list description."
    When I press "shelf_submit"
    Then I am on "MyList" admin camp shelf page
    Then I should see "MyList"
    Then I should see "My list description."
    Then should exist a camp shelf named "MyList"
