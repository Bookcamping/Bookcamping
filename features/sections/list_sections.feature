Feature: List Sections
  In order to find some references in chaos
  As a #bookcamping user
  I want to see all #bookcamping references

  @wip
  Scenario: List all sections
    Given a section named "Primera"
    Given a section named "Segunda"
    When I go to sections page
    Then I should see "Primera"
    Then I should see "Segunda"
