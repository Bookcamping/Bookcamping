Feature: List Sections
  In order to find some references in chaos
  As a #bookcamping user
  I want to see all #bookcamping references

  @wip
  Scenario: List all sections
    Given a camp's shelf named "Primera"
    Given a camp's shelf named "Segunda"
    When I go to camp's shelves page
    Then I should see "Primera"
    Then I should see "Segunda"
