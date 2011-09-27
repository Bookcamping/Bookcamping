Feature: Add a reference
  As a #bookcamping user
  In order to share the things I love
  I want to add some some reference

  @wip
  Scenario: Add a non-existent reference
    Given I am authenticated as "Jess"
    When I go to dashboard page
    And I follow "new-reference"
    And fill in "title" with "Codigo fuente: la remezcla"
    And fill in "type" with "Libro"
    And fill in "section" with "Cultura libre"
    And press "submit"
    Then I should be on "Codigo fuente: la remezcla" reference page

