Feature: List camp shelves features
  In order to dimiss the chaos
  As a #bookcamping admin
  I want to list the camp shelves

  Background:
    Given I'm at camp "testcamping"
    And I'm authenticated as "admin"
    And I'm an admin

  @wip
  Scenario: Only show camp shelves
    Given debug sql on
    Given a camp's shelf named "CampShelf"
    And a curated shelf named "CuratedShelf"
    And a user's shelf named "UserShelf"
    Given debug sql off
    When I go to admin camp shelves page
    Then debug page
    Then I should see "CampShelf"
    And I should not see "CuratedShelf"
    And I should not see "UserShelf"


