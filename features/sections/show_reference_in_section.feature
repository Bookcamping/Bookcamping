Feature: Show reference in section
  In order to not hide section context
  As a #bookcamping user
  I want to see a resume of the reference while browsing the section

  Background:
    Given a section named "My section"
    And a book titled "Reference 1" inside section "My section"
    And a book titled "Reference 2" inside section "My section"
    And a book titled "Reference 3" inside section "My section"

  @current
  Scenario: Visit a reference inside a section
    When I go to "My section" section page
    And follow "Reference 1"
    Then I am on "Reference 1" at "My section" section page
    And should see "My section"
    And should see "Volver"