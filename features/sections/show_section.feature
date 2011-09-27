Feature: Show section
  In order to find some references in chaos
  As a #bookcamping-er
  I want to see the references in each section

  @wip
  Scenario: View references in section
    Given a section named "Cultura Libre"
    And a book titled "Código fuente" inside section "Cultura libre"
    When I go to "Cultura Libre" section page
    Then I should see "Código fuente"

