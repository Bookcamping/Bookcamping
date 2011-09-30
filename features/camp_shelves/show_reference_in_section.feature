Feature: Show reference in section
  In order to not hide section context
  As a #bookcamping user
  I want to see a resume of the reference while browsing the section

  Background:
    Given a camp's shelf named "My section"
    And a book titled "Reference 1" inside shelf "My section"
    Given a user's shelf named "My shelf"
    And the reference titled "Reference 1" inside shelf "My shelf"

  @current
  Scenario: Visit a reference inside a camp's shelf
    When I go to "My section" camp's shelf page
    And follow "Reference 1"
    Then I am on "Reference 1" at "My section" camp's shelf page
    And should see "My section"
    And should see "Volver"
    And should not see "My shelf"