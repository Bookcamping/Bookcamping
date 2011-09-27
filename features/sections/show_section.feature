Feature: Show section
  In order to find some references in chaos
  As a #bookcamping-er
  I want to see the references in each section

  Background:
    Given a camp named "bookcamping"

  Scenario: View references in section
    Given a section named "Cultura Libre"
    And a book titled "Código fuente" inside section "Cultura Libre"
    And a book titled "Zemos98" inside section "Cultura Libre"
    When I go to "Cultura Libre" section page
    Then I should see "Código fuente"
    Then I should see "Zemos98"

